/** @type {import('tailwindcss').Config} */
export default {
  content: ["./index.html", "./src/**/*.{vue,js}"],
  theme: {
    extend: {
      backgroundImage: {
        "home-background": "url('/src/assets/img/home-background.jpg')",
        "login-background": "url('/src/assets/img/login-background.jpg')",
        "personalCenter-background":
          "url('/src/assets/img/personalCenter-background.jpg')",
        "web-logo": "url('/src/assets/img/logo.png')",
        "notice-background": "url('/src/assets/img/notice-background.jpg')",
        "admin-background": "url('/src/assets/img/admin-background.jpg')",
        "follow-background": "url('/src/assets/img/follow-background.jpg')",
        "order-background": "url('/src/assets/img/order-background.png')",
        "productBuyCenter-background":
          "url('/src/assets/img/productBuyCenter-background.jpg')",
        "cart-background": "url('/src/assets/img/cart-background.jpeg')",
      },
      margin: {
        18: "4.5rem",
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
