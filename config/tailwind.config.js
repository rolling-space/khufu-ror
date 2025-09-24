import forms from "@tailwindcss/forms";
import aspectRatio from "@tailwindcss/aspect-ratio";
import typography from "@tailwindcss/typography";
import containerQueries from "@tailwindcss/container-queries";
import defaultTheme from "tailwindcss/defaultTheme";
import shadcnConfig from "./shadcn.tailwind";

export default {
  // content: [
  //   "./public/*.html",
  //   "./app/helpers/**/*.rb",
  //   "./app/javascript/**/*.js",
  //   "./app/views/**/*.{erb,haml,html,slim}",
  // ],
  // theme: {
  //   extend: {
  //     fontFamily: {
  //       sans: ["Inter var", ...defaultTheme.fontFamily.sans],
  //     },
  //   },
  // },
  // plugins: [forms, aspectRatio, typography, containerQueries],
  ...shadcnConfig,
};
