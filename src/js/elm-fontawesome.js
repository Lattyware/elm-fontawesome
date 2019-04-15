"use strict";

import "core-js/stable";
import "regenerator-runtime/runtime";
import "make-promises-safe";
import "source-map-support/register";
import { exec as exec_internal } from "child_process";
import { stripIndents } from "common-tags";
import * as fs from "fs-extra";
import { dom } from "@fortawesome/fontawesome-svg-core";
import { promisify } from "util";

const exec = promisify(exec_internal);

const srcElm = "src/elm/";
const dist = "dist/";
const distSrc = `${dist}src/`;
const iconModuleName = "Icon";
const attributesName = "Attributes";
const stylesName = "Styles";
const layeringName = "Layering";
const transformsName = "Transforms";

const attrLinkPrefix = "https://fontawesome.com/how-to-use/on-the-web/styling/";
const attrs = [
  {
    title: "Sizing Icons",
    link: "sizing-icons",
    functions: [
      "xs",
      "sm",
      "lg",
      "2x",
      "3x",
      "4x",
      "5x",
      "6x",
      "7x",
      "8x",
      "9x",
      "10x"
    ]
  },
  {
    title: "Fixed Width Icons",
    link: "fixed-width-icons",
    functions: ["fw"]
  },
  {
    title: "Icons in a List",
    link: "icons-in-a-list",
    functions: ["ul", "li"]
  },
  {
    title: "Rotating Icons",
    link: "rotating-icons",
    functions: [
      "rotate-90",
      "rotate-180",
      "rotate-270",
      "flip-horizontal",
      "flip-vertical"
    ]
  },
  {
    title: "Animating Icons",
    link: "animating-icons",
    functions: ["spin", "pulse"]
  },
  {
    title: "Bordered + Pulled Icons",
    link: "bordered-pulled-icons",
    functions: ["pull-left", "pull-right", "border"]
  },
  {
    title: "Stacked Icons",
    link: "stacking-icons",
    functions: ["stack", "stack-1x", "stack-2x", "inverse"]
  }
];

function build(packs) {
  buildPacks(packs)
    .then(_ => console.log("Successful build."))
    .catch(err => {
      throw err;
    });
}

const modulePath = name => ["FontAwesome", name];
const moduleElm = name => modulePath(name).join(".");
const moduleFile = name => `${modulePath(name).join("/")}.elm`;

const writeModule = (name, contents) =>
  fs.outputFile(`${distSrc}${moduleFile(name)}`, contents);

const docSection = section => {
  const funcs = section.extra || [];
  funcs.push(...section.functions.map(asIdentifier));
  return stripIndents`
      # ${section.title}
      [See the FontAwesome docs for details.](${attrLinkPrefix}${section.link})
      @docs ${funcs.join(",")}
      `;
};

const module = (name, icons) => stripIndents`
    module ${moduleElm(name)} exposing (..)
       
    {-| Icons from the "${name}" pack. 
    @docs ${icons.map(i => asIdentifier(i.iconName)).join(",")}
    -}

    import ${moduleElm("Icon")} exposing (..)
   
    ${icons.map(iconDefinition).join("\n\n")}
  `;

function attributes() {
  return stripIndents`
    module ${moduleElm(attributesName)} exposing (..)
    
    {-| Styling attributes for icons. 
    ${attrs.map(docSection).join("\n\n")}
    -}
    
    import Svg
    import Svg.Attributes as SvgA
    
    ${attrs
      .flatMap(section => section.functions)
      .map(attribute)
      .join("\n\n")}
  `;
}

function attribute(name) {
  const fullName = `fa-${name}`;
  const identifier = asIdentifier(name);
  return stripIndents`
    {-| Apply the \`${fullName}\` class to the element. -}
    ${identifier} : Svg.Attribute msg
    ${identifier} = SvgA.class "${fullName}"
  `;
}

function styles() {
  const css = dom
    .css()
    .replace(/(\r\n\t|\n|\r\t)/gm, "")
    .replace(/"/g, '\\"');
  return stripIndents`
    module ${moduleElm(stylesName)} exposing (..)
    
    {-| Helpers for adding the CSS required for FontAwesome to your page. 
    @docs css
    -}
    
    import Html exposing (Html)
    
    {-| Generates the accompanying CSS that is necessary to correctly display icons. -}
    css : Html msg
    css = Html.node "style" [] [ Html.text "${css}" ]
  `;
}

async function buildPacks(packs) {
  await fs.remove(dist);
  await fs.copy(srcElm, distSrc, { overwrite: true });
  const loadedPacks = await Promise.all(
    packs.map(moduleFromPack),
    writeModule(attributesName, attributes()),
    writeModule(stylesName, styles())
  );
  const names = loadedPacks
    .filter(pack => pack != null)
    .map(pack => pack.name)
    .concat(
      attributesName,
      stylesName,
      layeringName,
      iconModuleName,
      transformsName
    );
  await elmJson(names);
  await Promise.all(
    names.map(name =>
      exec(`elm-format src/${moduleFile(name)} --yes`, { cwd: dist })
    )
  );
}

async function moduleFromPack(pack) {
  let imported;
  try {
    imported = await import(pack.pkg);
  } catch (err) {
    console.log(`"${pack.pkg}" not available and won't be included: ${err}.`);
    return null;
  }
  const icons = Object.values(imported[pack.pack]);
  await writeModule(pack.name, module(pack.name, icons));
  console.log(`Successfully generated "${pack.name}" module.`);
  return pack;
}

async function elmJson(names) {
  const modules = names.map(name => moduleElm(name));
  const elm = {
    type: "package",
    name: "lattyware/elm-fontawesome",
    summary: "FontAwesome 5 SVG icons.",
    license: "MIT",
    version: "2.3.0",
    "exposed-modules": modules,
    "elm-version": "0.19.0 <= v < 0.20.0",
    dependencies: {
      "elm/core": "1.0.2 <= v < 2.0.0",
      "elm/html": "1.0.0 <= v < 2.0.0",
      "elm/svg": "1.0.1 <= v < 2.0.0"
    },
    "test-dependencies": {}
  };
  await fs.outputFile(`${dist}elm.json`, JSON.stringify(elm, null, 2));
}

function styleSuffix(prefix) {
  switch (prefix) {
    case "fas":
      return "?style=solid";
    case "far":
      return "?style=regular";
    case "fal":
      return "?style=light";
    case "fab":
      return "?style=brands";
    default:
      return "";
  }
}

function iconDefinition(iconDef) {
  const prefix = iconDef.prefix;
  const iconName = iconDef.iconName;
  const identifier = asIdentifier(iconName);
  const [width, height, ligatures, unicode, d] = iconDef.icon;

  const link = `${iconName}${styleSuffix(prefix)}`;

  return stripIndents`
    {-| The [\`${iconName}\`](https://fontawesome.com/icons/${link}) icon. -}
    ${identifier} : Icon
    ${identifier} = Icon "${prefix}" "${iconName}" ${width} ${height} "${d}"
  `;
}

function asIdentifier(str) {
  const capWords = str
    .split(/[^\p{Lu}\p{Ll}\p{Lt}\p{Lm}\p{Lo}\p{Nd}\p{Nl}_]/u)
    .map(n => n[0].toUpperCase() + n.slice(1))
    .join("");
  const camelCase = capWords[0].toLowerCase() + capWords.slice(1);
  return /^\p{Ll}.*$/u.test(camelCase) ? camelCase : "fa" + camelCase;
}

export { build };
