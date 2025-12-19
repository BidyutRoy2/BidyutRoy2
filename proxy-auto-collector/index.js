#!/usr/bin/env node
import { execSync } from "child_process";
import fs from "fs";
import path from "path";
import chalk from "chalk";
import cliProgress from "cli-progress";

/* ================= LOAD VERSION (NODE SAFE) ================= */

const pkg = JSON.parse(
  fs.readFileSync(
    path.join(process.cwd(), "package.json"),
    "utf8"
  )
);

/* ================= VERSION BANNER ================= */

console.clear();
console.log(
  chalk.cyanBright.bold(`
╔══════════════════════════════════════════════╗
║        Proxy Auto Collector                  ║
║   Powered by ⚡ | ＨｉｄｄｅｎＧｅｍ          ║
╚══════════════════════════════════════════════╝
`)
);

/* ================= ANIMATED LOGO ================= */

const frames = [
  chalk.green("▖"),
  chalk.green("▘"),
  chalk.green("▝"),
  chalk.green("▗")
];

process.stdout.write(chalk.yellow("Loading....."));
for (let i = 0; i < 12; i++) {
  process.stdout.write(frames[i % frames.length]);
  await new Promise(r => setTimeout(r, 80));
  process.stdout.write("\b");
}
console.log("\n");

/* ================= REMOTE LOGO ================= */

try {
  execSync(`
    echo "-----------------------------------------------------------------------------"
    curl -fsSL https://raw.githubusercontent.com/BidyutRoy2/BidyutRoy2/main/logo.sh | bash || \
    echo "[!] Logo load failed (ignored)"
    echo "-----------------------------------------------------------------------------"
  `, { stdio: "inherit", shell: "/bin/bash" });
} catch {}

/* ================= PATHS ================= */

const BASE = process.cwd();
const SOURCES = path.join(BASE, "sources");
const REPOS = path.join(BASE, "repos.txt");

/* ================= PRE-CHECK ================= */

if (!fs.existsSync("proxy-engine")) {
  console.log(chalk.red("❌ proxy-engine not found"));
  console.log(chalk.yellow("Run: go build -o proxy-engine"));
  process.exit(1);
}

if (!fs.existsSync(REPOS)) {
  console.log(chalk.red("❌ repos.txt not found"));
  process.exit(1);
}

fs.mkdirSync(SOURCES, { recursive: true });

/* ================= PROGRESS BAR ================= */

const repos = fs.readFileSync(REPOS, "utf8")
  .split("\n")
  .map(l => l.trim())
  .filter(l => l.endsWith(".git"));

const bar = new cliProgress.SingleBar({
  format: chalk.cyan("Downloading...") + barFormat(),
}, cliProgress.Presets.shades_classic);

function barFormat() {
  return "{bar} {value}/{total}";
}

bar.start(repos.length, 0);

/* ================= FETCH SOURCES ================= */

for (const url of repos) {
  const name = url.split("/").pop().replace(".git", "");
  const dest = path.join(SOURCES, name);

  if (fs.existsSync(path.join(dest, ".git"))) {
    execSync(`git -C "${dest}" pull`, { stdio: "ignore" });
  } else {
    execSync(`git clone "${url}" "${dest}"`, { stdio: "ignore" });
  }

  bar.increment();
}

bar.stop();

/* ================= RUN GO ENGINE ================= */

console.log(chalk.magentaBright("\n⚡Running HiddenGem Proxy Engine...\n"));
execSync("./proxy-engine", { stdio: "inherit" });

console.log(chalk.greenBright("\n✅ DONE — results Save in proxyresult/\n"));
console.log(chalk.greenBright("\n Type - cd proxyresult & Check txt File \n"));
