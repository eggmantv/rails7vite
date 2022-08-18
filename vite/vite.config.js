import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  logLevel: "info",
  server: {
    host: true,
    port: 3036,
    origin: 'http://localhost:3036',
  },
})
