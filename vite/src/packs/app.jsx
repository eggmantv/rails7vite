import { createRoot } from 'react-dom/client'

import '../styles/app.css'

const container = document.getElementById('root');
const appRoot = createRoot(container);
window.appRoot = appRoot;