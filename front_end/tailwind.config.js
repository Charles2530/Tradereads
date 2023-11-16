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
    },
  },
  plugins: [],
};
