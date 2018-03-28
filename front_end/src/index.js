import "@fortawesome/fontawesome";
import "@fortawesome/fontawesome-free-solid";
import "@fortawesome/fontawesome-free-regular";
import "tachyons";
import "./main.css";
import { Main } from "./Main.elm";

Main.embed(document.getElementById("root"), {
  apiUrl: process.env.ELM_APP_API_URL
});
