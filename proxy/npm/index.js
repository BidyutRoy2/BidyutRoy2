#!/usr/bin/env node
import { execSync } from "child_process";
import fs from "fs";

console.log(" Proxy Auto Collector - ＨｉｄｄｅｎＧｅｍ ");

if (!fs.existsSync("./proxy-engine")) {
  console.error("❌ Go binary not found. Run: go build");
  process.exit(1);
}

execSync("./proxy-engine", { stdio: "inherit" });
