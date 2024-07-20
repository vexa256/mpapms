import { createApp } from 'vue';
import App from './App.vue';
import router from './router';
import axiosInstance from './axios-interceptor'; // Import the Axios instance
import FullScreenLoader from './components/FullScreenLoader.vue'; // Import the loader component
import './conf'
// Set the Axios instance globally so it can be used in the app
const app = createApp(App);
app.config.globalProperties.$axios = axiosInstance;

app.component('FullScreenLoader', FullScreenLoader); // Register the loader component globally

app.use(router).mount('#app');

