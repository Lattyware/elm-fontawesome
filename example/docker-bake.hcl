# The path to find the library at.
variable "FONTAWESOME_CONTEXT" {
  default = ".."
}

# The elm package for the library.
variable "FONTAWESOME_PACKAGE" {
  default = "lattyware/elm-fontawesome"
}

# If "context" then we will look at the path FONTAWESOME_CONTEXT to find the 
# library, and copy it in as a "lib" directory.
# If "package" then we will install the package FONTAWESOME_PACKAGE with the 
# elm package manager.
variable "FONTAWESOME_SOURCE" {
  default = "context"
}

target "build" {
  dockerfile = "./Dockerfile"
  output = ["type=local,dest=dist"]
  pull = true
  args = {
    ELM_FONTAWESOME_PACKAGE = "${FONTAWESOME_PACKAGE}"
    ELM_FONTAWESOME_SOURCE = "${FONTAWESOME_SOURCE}"
  }
  contexts = {
    fontawesome = "${FONTAWESOME_CONTEXT}"
  }
}

group "default" {
  targets = [ "build" ]
}
