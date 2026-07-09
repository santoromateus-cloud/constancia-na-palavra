import type { Config } from "tailwindcss";
const config: Config = {
  content: ["./src/**/*.{ts,tsx}"],
  theme: {
    extend: {
      colors: {
        ink: "#1c2233", base: "#2f4858", mare: "#33658a", coral: "#e07a5f",
        areia: "#f2cc8f", creme: "#f7f5f1", verde: "#2a9d8f", telha: "#e76f51",
        paper: "#fffdfa", line: "#e7e3da",
      },
      fontFamily: { serif: ["var(--font-fraunces)", "Georgia", "serif"], sans: ["var(--font-inter)", "system-ui", "sans-serif"] },
    },
  },
  plugins: [],
};
export default config;
