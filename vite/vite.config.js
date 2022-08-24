import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'
import postcssImport from "postcss-import"
import autoprefixer from 'autoprefixer'

const devPort = 3036;

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  logLevel: "info",
  server: {
    host: true,
    port: devPort,
    origin: `http://localhost:${devPort}`,
  },
  css: {
    postcss: {
      plugins: [
        postcssImport,
        autoprefixer,
      ]
    }
  },
  build: {
    manifest: true,
    assetsDir: "packs/assets",
    rollupOptions: {
      input: [
        "./src/packs/app.jsx",
        "./src/packs/home/index.jsx",
      ]
    }
  }
})
