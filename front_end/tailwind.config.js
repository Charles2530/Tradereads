/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{vue,js}"],
  theme: {
    extend: {
      backgroundImage: {
        "login-background": "url('/src/assets/img/login-background.jpg')",
        "personalCenter-background":
          "url('/src/assets/img/personalCenter-background.jpg')",
        "web-logo": "url('/src/assets/img/logo.png')",
      },
      margin: {
        100: "100px",
        150: "150px",
        250: "250px",
        300: "300px",
        350: "350px",
        400: "400px",
        600: "600px",
      },
    },
  },
  plugins: [],
};
