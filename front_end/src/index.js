import "@fortawesome/fontawesome";
import "@fortawesome/fontawesome-free-solid";
import "@fortawesome/fontawesome-free-regular";
import "flag-icon-css/css/flag-icon.css"
import "tachyons";
import { Main } from "./Main.elm";

document.addEventListener("DOMContentLoaded", () => {
  const appContainer = document.querySelector("#root");

  if (appContainer) {
    const app =
      Main.embed(appContainer, {
        environment: process.env.NODE_ENV,
        apiUrl: process.env.ELM_APP_API_URL,
        language: navigator.language || navigator.userLanguage
      });

    app.ports.updateTitle.subscribe((newTitle) => {
      window.document.title = newTitle;
    });
  }
});
