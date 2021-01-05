import { createApp } from 'vue'
import HelloWorld from '@/components/HelloWorld.vue'
import router from '@/components/router.js'

export default () => {
    document.addEventListener('DOMContentLoaded', () => {
        const app = createApp(HelloWorld)
        app.use(router)
        app.mount('#vue-app')
    })
}
