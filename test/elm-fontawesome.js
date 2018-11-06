"use strict";

import "@babel/polyfill";
import { exec as exec_internal } from "child_process";
import { promisify } from "util";

const exec = promisify(exec_internal);

describe("The built Elm code", async () => {
  it("compiles", async () => {
    await exec("elm make", { cwd: "dist" });
  });
});
