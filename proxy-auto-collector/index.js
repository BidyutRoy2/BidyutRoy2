#!/usr/bin/env node
import { execSync } from "child_process";
import fs from "fs";
import path from "path";

console.log("🚀 Proxy Auto Collector - HiddenGem");

const BASE = process.cwd();
const SOURCES = path.join(BASE, "sources");
const REPOS = path.join(BASE, "repos.txt");

if (!fs.existsSync("proxy-engine")) {
  console.error("❌ proxy-engine not found");
  console.error("Run: go build -o proxy-engine");
  process.exit(1);
}

if (!fs.existsSync(REPOS)) {
  console.error("❌ repos.txt not found");
  process.exit(1);
}

fs.mkdirSync(SOURCES, { recursive: true });

const list = fs.readFileSync(REPOS, "utf8")
  .split("\n")
  .map(l => l.trim())
  .filter(l => l.endsWith(".git"));

console.log(`📦 Fetching ${list.length} repositories...`);

for (const url of list) {
  const name = url.split("/").pop().replace(".git", "");
  const dest = path.join(SOURCES, name);

  if (fs.existsSync(path.join(dest, ".git"))) {
    console.log(`🔄 Updating ${name}`);
    execSync(`git -C ${dest} pull`, { stdio: "ignore" });
  } else {
    console.log(`📥 Cloning ${name}`);
    execSync(`git clone ${url} ${dest}`, { stdio: "ignore" });
  }
}

console.log("⚡ Running Go proxy engine...");
execSync("./proxy-engine", { stdio: "inherit" });

console.log("✅ DONE — results in proxyresult/");
