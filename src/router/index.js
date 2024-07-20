import { createRouter, createWebHistory } from 'vue-router'
import Home from '../components/Home.vue'
import MgtEntities from '../views/Entities/MgtEntities.vue'
import MgtTimelines from '../views/Timelines/MgtTimelines.vue'
import ReportStatus from '../views/Timelines/ReportStatus.vue'
import MgtIndicators from '../views/Indicators/MgtIndicators.vue'
import SelectEntity from '../views/Indicators/SelectEntity.vue'
import Admins from '../views/Uac/Admins.vue'

const routes = [{
    path: '/',
    name: 'Home',
    component: Home
}, {
    path: '/MgtEntities',
    name: 'MgtEntities',
    component: MgtEntities
},

{
    path: '/MgtTimelines',
    name: 'MgtTimelines',
    component: MgtTimelines
},


{
    path: '/ReportStatus',
    name: 'ReportStatus',
    component: ReportStatus
},
{
    path: '/MgtIndicators',
    name: 'MgtIndicators',
    component: MgtIndicators
},

{
    path: '/SelectEntity',
    name: 'SelectEntity',
    component: SelectEntity
},


{
    path: '/Admins',
    name: 'Admins',
    component: Admins
},

]

const router = createRouter({
    history: createWebHistory(),
    routes
})

export default router