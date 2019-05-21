// REF: https://fontawesome.com/how-to-use/on-the-web/setup/hosting-font-awesome-yourself#using-svgs
import "@fortawesome/fontawesome-free/js/all"
import "flag-icon-css/css/flag-icon.css"
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

app.ports.initBodyProperties.subscribe(classes => {
  document.body.className = classes
})

app.ports.storeLanguage.subscribe(language => {
  localStorage.setItem("survey-tool-language", language)
})

function getLanguage() {
  return localStorage.getItem("survey-tool-language") ||
    navigator.language ||
    navigator.userLanguage
}
