// REF: https://fontawesome.com/how-to-use/on-the-web/setup/hosting-font-awesome-yourself#using-svgs
import "@fortawesome/fontawesome-free/js/all"
import "flag-icons/css/flag-icons.css";
import "tachyons"
import { Elm } from "./Main.elm";

const app =
  Elm.Main.init({
    flags: {
      environment: process.env.NODE_ENV,
      apiUrl: process.env.ELM_APP_API_URL,
      language: getLanguage()
    }
  })

app.ports.outbound.subscribe(({ tag, data }) => {
  switch (tag) {
  case "INIT_BODY_CLASSES":
    document.body.className = data.classes
    break
  case "STORE_LANGUAGE":
    localStorage.setItem("survey-tool-language", data.language)
    break
  }
})

function getLanguage() {
  return localStorage.getItem("survey-tool-language") ||
    navigator.language ||
    navigator.userLanguage
}
