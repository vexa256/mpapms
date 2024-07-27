// src/main.js
import { createApp } from 'vue';
import App from './App.vue';
import router from './router';
import pb from './pocketbase.js'; // Import the Axios instance
import FullScreenLoader from './components/FullScreenLoader.vue'; // Import the loader component


import emailjs from '@emailjs/browser';

emailjs.init('xWOiexQqcfZQ5cchR');

const app = createApp(App);

// app.config.globalProperties.$axios = axiosInstance;

app.component('FullScreenLoader', FullScreenLoader); // Register the loader component globally

app.use(router).mount('#app');
