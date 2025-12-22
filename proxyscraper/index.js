import fs from "fs";
import axios from "axios";
import gradient from "chalk-gradient";
import figlet from "figlet";
import inquirer from "inquirer";
import cliProgress from "cli-progress";
import winston from "winston";
import chalk from "chalk";
import pLimit from "p-limit";
import { exec } from "child_process";
import { HttpsProxyAgent } from "https-proxy-agent";
import { SocksProxyAgent } from "socks-proxy-agent";

/* ================= CONFIG ================= */
const TIMEOUT = 5000;
const CONCURRENCY = 150;
const TEST_URL = "https://api.ipify.org";

/* ================= INIT ================= */
["output", "update", "logs"].forEach(d => {
  if (!fs.existsSync(d)) fs.mkdirSync(d);
});

const limit = pLimit(CONCURRENCY);

/* ================= LOGGER ================= */
const logger = winston.createLogger({
  level: "info",
  format: winston.format.combine(
    winston.format.timestamp(),
    winston.format.printf(
      ({ level, message, timestamp }) =>
        `${timestamp} [${level.toUpperCase()}] ${message}`
    )
  ),
  transports: [new winston.transports.File({ filename: "logs/app.log" })]
});

const log = (type, msg) => {
  const colors = {
    info: chalk.cyan,
    success: chalk.green,
    warn: chalk.yellow,
    error: chalk.red
  };
  console.log(colors[type](msg));
  logger.log({ level: type === "success" ? "info" : type, message: msg });
};

/* ================= LOGO ================= */
function showExternalLogo() {
  return new Promise(resolve => {
    console.log("-----------------------------------------------------------------------------");
    exec(
      "curl -s https://raw.githubusercontent.com/BidyutRoy2/BidyutRoy2/main/logo.sh | bash",
      () => {
        console.log("-----------------------------------------------------------------------------");
        resolve();
      }
    );
  });
}

/* ================= UI ================= */
function banner() {
  console.clear();
  console.log(
    gradient.rainbow(
      figlet.textSync("Proxy Scraper", { font: "Slant" })
    )
  );
}

async function menu() {
  const { action } = await inquirer.prompt([
    {
      type: "list",
      name: "action",
      message: "Select action",
      choices: [
        { name: "🚀 Start Scanning", value: "scan" },
        { name: "⚡ Speed Ranking", value: "speed" },
        { name: "📊 Check Proxy Result", value: "result" },
        { name: "♻ Upgrade New Proxy", value: "upgrade" },
        { name: "❌ Exit", value: "exit" }
      ]
    }
  ]);
  return action;
}

/* ================= HELPERS ================= */
const loadFile = f =>
  fs.existsSync(f)
    ? new Set(fs.readFileSync(f, "utf8").split("\n").filter(Boolean))
    : new Set();

const fetchList = async url => {
  try {
    const r = await axios.get(url, { timeout: 10000 });
    return r.data.split("\n").map(x => x.trim()).filter(Boolean);
  } catch {
    return [];
  }
};

async function checkHttp(proxy) {
  try {
    const agent = new HttpsProxyAgent(`http://${proxy}`);
    const t = Date.now();
    await axios.get(TEST_URL, { httpsAgent: agent, timeout: TIMEOUT });
    return Date.now() - t;
  } catch {
    return null;
  }
}

async function checkSocks(proxy, v) {
  try {
    const agent = new SocksProxyAgent(`${v}://${proxy}`);
    const t = Date.now();
    await axios.get(TEST_URL, { httpsAgent: agent, timeout: TIMEOUT });
    return Date.now() - t;
  } catch {
    return null;
  }
}

/* ================= CORE ================= */
async function scan(upgrade = false) {
  log("info", "Fetching proxy sources...");
  const sources = fs.readFileSync("sources.txt", "utf8")
    .split("\n").filter(Boolean);

  const pool = { http: new Set(), socks4: new Set(), socks5: new Set() };

  for (const url of sources) {
    const list = await fetchList(url);
    list.forEach(p => {
      if (url.includes("socks5")) pool.socks5.add(p);
      else if (url.includes("socks4")) pool.socks4.add(p);
      else pool.http.add(p);
    });
  }

  const old = {
    http: loadFile("output/http.txt"),
    socks4: loadFile("output/socks4.txt"),
    socks5: loadFile("output/socks5.txt")
  };

  for (const type of ["http", "socks4", "socks5"]) {
    const proxies = [...pool[type]];
    const bar = new cliProgress.SingleBar(
      { format: `${type} |{bar}| {value}/{total} Alive:{alive}` },
      cliProgress.Presets.shades_classic
    );

    bar.start(proxies.length, 0, { alive: 0 });
    let aliveCount = 0;
    const alive = [];

    await Promise.all(
      proxies.map(p =>
        limit(async () => {
          const ok =
            type === "http"
              ? await checkHttp(p)
              : await checkSocks(p, type);

          if (ok !== null && (!upgrade || !old[type].has(p))) {
            alive.push(p);
            aliveCount++;
          }
          bar.increment(1, { alive: aliveCount });
        })
      )
    );

    bar.stop();
    const file = upgrade
      ? `update/${type}_new.txt`
      : `output/${type}.txt`;

    fs.writeFileSync(file, alive.join("\n"));
    log("success", `${type.toUpperCase()} saved: ${alive.length}`);
  }
}

async function speedRank() {
  const proxies = [...loadFile("output/http.txt")];
  const ranked = [];

  for (const p of proxies) {
    const s = await checkHttp(p);
    if (s !== null) ranked.push({ p, s });
  }

  ranked.sort((a, b) => a.s - b.s);
  fs.writeFileSync(
    "output/http_speed_rank.txt",
    ranked.map(x => `${x.p} | ${x.s}ms`).join("\n")
  );
  log("success", "Speed ranking saved");
}

function showResult() {
  ["http", "socks4", "socks5"].forEach(t =>
    log("info", `${t.toUpperCase()}: ${loadFile(`output/${t}.txt`).size}`)
  );
}

/* ================= APP ================= */
async function app() {
  await showExternalLogo();

  while (true) {
    banner();
    const action = await menu();

    if (action === "scan") {
      await scan(false);
      await showExternalLogo();
    }

    if (action === "speed") {
      await speedRank();
      await showExternalLogo();
    }

    if (action === "result") {
      showResult();
      await showExternalLogo();
    }

    if (action === "upgrade") {
      await scan(true);
      await showExternalLogo();
    }

    if (action === "exit") {
      console.log("-----------------------------------------------------------------------------");
      process.exit();
    }
  }
}

app();
