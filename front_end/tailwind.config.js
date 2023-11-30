/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{vue,js}"],
  theme: {
    extend: {
      backgroundImage: {
        "login-background": "url('/src/assets/img/login-background.jpg')",
        "personalCenter-background":
          "url('/src/assets/img/personalCenter-background.jpg')",
      },
      margin: {
        100: "100px",
        150: "150px",
        250: "250px",
      },
    },
  },
  plugins: [],
};
