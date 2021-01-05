import { createRouter, createWebHistory } from 'vue-router'
import EmployeeIndexPage from '@/components/pages/EmployeeIndexPage.vue'
import EmployeeDetailPage from '@/components/pages/EmployeeDetailPage.vue'
import EmployeeNewPage from '@/components/pages/EmployeeNewPage.vue'
import EmployeeEditPage from '@/components/pages/EmployeeEditPage.vue'

const routerHistory = createWebHistory()

const routes = [
    { path: '/', component: EmployeeIndexPage },
    { path: '/employees/:id(\\d+)',
      name: 'EmployeeDetailPage',  
      component: EmployeeDetailPage },// :id は数値のみに制限する
    { path: '/employees/new',
      name: 'EmployeeNewPage',
      component: EmployeeNewPage },
    { path: '/employees/:Id(\\d+)/edit',
      name: 'EmployeeEditPage',
      component: EmployeeEditPage }
    ];

  const router = createRouter({
    history: routerHistory,
    routes,
  });
  
  export default router;