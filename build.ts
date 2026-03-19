#!/usr/bin/env -S deno run --allow-read --allow-write

import * as msgpack from "https://deno.land/std@0.224.0/msgpack/mod.ts";
import * as yaml from "https://deno.land/std@0.224.0/yaml/mod.ts";

await Deno.mkdir("dist/yaml", { recursive: true });
await Deno.mkdir("dist/json", { recursive: true });
await Deno.mkdir("dist/mpk", { recursive: true });

for await (const f of Deno.readDir("yaml")) {
  if (!f.name.endsWith(".yaml")) continue;

  const yamlFilename = f.name;
  const baseName = yamlFilename.replace(".yaml", "");

  await Deno.copyFile("yaml/" + yamlFilename, "dist/yaml/" + yamlFilename);

  const jisyo = yaml.parse(await Deno.readTextFile("yaml/" + yamlFilename));

  await Deno.writeTextFile(
    "dist/json/" + baseName + ".json",
    JSON.stringify(jisyo),
  );

  await Deno.writeFile(
    "dist/mpk/" + baseName + ".mpk",
    msgpack.encode(jisyo as msgpack.ValueType),
  );
}
