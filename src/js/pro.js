"use strict";

import "source-map-support/register";
import { build } from "./elm-fontawesome";

build([
  {
    name: "Solid",
    pkg: "@fortawesome/pro-solid-svg-icons",
    pack: "fas"
  },
  {
    name: "Regular",
    pkg: "@fortawesome/pro-regular-svg-icons",
    pack: "far"
  },
  {
    name: "Light",
    pkg: "@fortawesome/pro-light-svg-icons",
    pack: "fal"
  },
  {
    name: "Brands",
    pkg: "@fortawesome/free-brands-svg-icons",
    pack: "fab"
  }
]);
