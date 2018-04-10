import "@fortawesome/fontawesome";
import "@fortawesome/fontawesome-free-solid";
import "@fortawesome/fontawesome-free-regular";
import "tachyons";
import { Main } from "./Main.elm";

Main.embed(document.getElementById("root"), {
  apiUrl: process.env.ELM_APP_API_URL
});
