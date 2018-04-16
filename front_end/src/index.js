import "@fortawesome/fontawesome";
import "@fortawesome/fontawesome-free-solid";
import "@fortawesome/fontawesome-free-regular";
import "tachyons";
import { Main } from "./Main.elm";

Main.embed(document.getElementById("root"), {
  environment: process.env.NODE_ENV
});
