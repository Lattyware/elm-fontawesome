"use strict";

import "source-map-support/register";
import { build } from "./elm-fontawesome";

build([
  {
    name: "Solid",
    pkg: "@fortawesome/free-solid-svg-icons",
    pack: "fas"
  },
  {
    name: "Regular",
    pkg: "@fortawesome/free-regular-svg-icons",
    pack: "far"
  },
  {
    name: "Brands",
    pkg: "@fortawesome/free-brands-svg-icons",
    pack: "fab"
  }
]);
