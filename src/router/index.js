import { createRouter, createWebHistory } from 'vue-router'
import Home from '../components/Home.vue'
import MgtEntities from '../views/Entities/MgtEntities.vue'
import MgtTimelines from '../views/Timelines/MgtTimelines.vue'
import ReportStatus from '../views/Timelines/ReportStatus.vue'
import MgtIndicators from '../views/Indicators/MgtIndicators.vue'
import SelectEntity from '../views/Indicators/SelectEntity.vue'
import SelectEntityReport from '../views/Report/SelectAnnualEntity.vue'
import SelectAnnualReport from '../views/Report/SelectAnnualReport.vue'
import ReportAnnual from '../views/Report/ReportAnnual.vue'
import SelectEntityBiAnnual from '../views/Bi_Annual/SelectEntity.vue'
import SelectReportBiAnnual from '../views/Bi_Annual/SelectReport.vue'
import ReportBiAnnual from '../views/Bi_Annual/Report.vue' // 
import Admins from '../views/Uac/Admins.vue'

import AQuarterlyViewReport from 
'/src/views/QuarterlyActiveReports/ViewQuarteryReport.vue'

import ABiAnnualSelectEntity from '/src/views/BiAnnualActiveReports/SelectEntity.vue'
import ABiAnnualSelectYear from '/src/views/BiAnnualActiveReports/SelectYear.vue'
import ABiAnnualSelectReport from '/src/views/BiAnnualActiveReports/SelectReport.vue'
import ABiViewAnnualReport from '/src/views/BiAnnualActiveReports/ViewBiAnnualReport.vue'

import AAnnualSelectEntity from '/src/views/AnnualActiveReports/SelectEntity.vue'
import AAnnualSelectYear from '/src/views/AnnualActiveReports/SelectYear.vue'
import AAnnualSelectReport from '/src/views/AnnualActiveReports/SelectReport.vue'
import AViewAnnualReport from '/src/views/AnnualActiveReports/ViewAnnualReport.vue'

import AQuarterlySelectEntity from '/src/views/QuarterlyActiveReports/SelectEntity.vue'
import AQuarterlySelectYear from '/src/views/QuarterlyActiveReports/SelectYear.vue'
import AQuarterlySelectReport from '/src/views/QuarterlyActiveReports/SelectReport.vue'


import RRFSelectEntity from '../views/RRF/SelectEntity.vue'
import RRFSelectReport from '../views/RRF/SelectReport.vue'
import RRFReport from '../views/RRF/Report.vue'

import QuaterlySelectEntity from '../views/Quartery/SelectEntity.vue'
import QuaterlySelectReport from '../views/Quartery/SelectReport.vue'
import ReportQuaterly from '../views/Quartery/Report.vue'


import ActiveRRFSelectEntity from '/src/views/RRFActiveReports/SelectEntity.vue'
import ActiveRRFSelectYear from '/src/views/RRFActiveReports/SelectYear.vue'
import ActiveRRFSelectReport from '/src/views/RRFActiveReports/SelectReport.vue'
import ActiveRRFViewReport from '/src/views/RRFActiveReports/ActiveRRFReport.vue'


import IAnnualReportsReportEntity from '/src/views/InnactiveAnnualReports/SelectEntity.vue'
import IAnnualReportsYear from '/src/views/InnactiveAnnualReports/SelectYear.vue'
import IAnnualReportsReport from '/src/views/InnactiveAnnualReports/SelectReport.vue'
import IAnnualReportsView from '/src/views/InnactiveAnnualReports/ViewReport.vue'

import IBiAnnualReportsReportEntity from '/src/views/InnactiveBiAnnualReports/SelectEntity.vue'
import IBiAnnualReportsYear from '/src/views/InnactiveBiAnnualReports/SelectYear.vue'
import IBiAnnualReportsReport from '/src/views/InnactiveBiAnnualReports/SelectReport.vue'
import IBiAnnualReportsView from '/src/views/InnactiveBiAnnualReports/ViewReport.vue'

import IQuarterlyReportsReportEntity from '/src/views/InnactiveQuarterlyReports/SelectEntity.vue'
import IQuarterlyReportsYear from '/src/views/InnactiveQuarterlyReports/SelectYear.vue'
import IQuarterlyReportsReport from '/src/views/InnactiveQuarterlyReports/SelectReport.vue'
import IQuarterlyReportsView from '/src/views/InnactiveQuarterlyReports/ViewReport.vue'

import IRRFReportsReportEntity from '/src/views/InnactiveRRFReports/SelectEntity.vue'
import IRRFReportsYear from '/src/views/InnactiveRRFReports/SelectYear.vue'
import IRRFReportsReport from '/src/views/InnactiveRRFReports/SelectReport.vue'
import IRRFReportsView from '/src/views/InnactiveRRFReports/ViewReport.vue'


import Countries from '../views/Uac/Countries.vue'
import Partners from '../views/Uac/Partners.vue'
import Login from '../views/Uac/Login.vue'


const routes = [


    {
        path: '/Login',
        name: 'Login',
        component: Login
    },
    {
        path: '/Countries',
        name: 'Countries',
        component: Countries
    },


    {
        path: '/Partners',
        name: 'Partners',
        component: Partners
    },







    {
        path: '/IRRFReportsReportEntity',
        name: 'IRRFReportsReportEntity',
        component: IRRFReportsReportEntity
    },

    {
        path: '/IRRFReportsYear',
        name: 'IRRFReportsYear',
        component: IRRFReportsYear
    },

    {
        path: '/IRRFReportsReport',
        name: 'IRRFReportsReport',
        component: IRRFReportsReport
    },

    {
        path: '/IRRFReportsView',
        name: 'IRRFReportsView',
        component: IRRFReportsView
    },
















    {
        path: '/IQuarterlyReportsReportEntity',
        name: 'IQuarterlyReportsReportEntity',
        component: IQuarterlyReportsReportEntity
    },{
        path: '/IQuarterlyReportsYear',
        name: 'IQuarterlyReportsYear',
        component: IQuarterlyReportsYear
    },{
        path: '/IQuarterlyReportsReport',
        name: 'IQuarterlyReportsReport',
        component: IQuarterlyReportsReport
    },{
        path: '/IQuarterlyReportsView',
        name: 'IQuarterlyReportsView',
        component: IQuarterlyReportsView
    },














    {
        path: '/IBiAnnualReportsReportEntity',
        name: 'IBiAnnualReportsReportEntity',
        component: IBiAnnualReportsReportEntity
    },
    {
        path: '/IBiAnnualReportsYear',
        name: 'IBiAnnualReportsYear',
        component: IBiAnnualReportsYear
    },
    {
        path: '/IBiAnnualReportsReport',
        name: 'IBiAnnualReportsReport',
        component: IBiAnnualReportsReport
    },
    {
        path: '/IBiAnnualReportsView',
        name: 'IBiAnnualReportsView',
        component: IBiAnnualReportsView
    },

















    {
        path: '/IAnnualReportsReportEntity',
        name: 'IAnnualReportsReportEntity',
        component: IAnnualReportsReportEntity
    },

    {
        path: '/IAnnualReportsYear',
        name: 'IAnnualReportsYear',
        component: IAnnualReportsYear
    },

    {
        path: '/IAnnualReportsReport',
        name: 'IAnnualReportsReport',
        component: IAnnualReportsReport
    },
    {
        path: '/IAnnualReportsView',
        name: 'IAnnualReportsView',
        component: IAnnualReportsView
    },










    {
        path: '/ActiveRRFSelectEntity',
        name: 'ActiveRRFSelectEntity',
        component: ActiveRRFSelectEntity
    }, {
        path: '/ActiveRRFSelectYear',
        name: 'ActiveRRFSelectYear',
        component: ActiveRRFSelectYear
    }, {
        path: '/ActiveRRFSelectReport',
        name: 'ActiveRRFSelectReport',
        component: ActiveRRFSelectReport
    }, {
        path: '/ActiveRRFViewReport',
        name: 'ActiveRRFViewReport',
        component: ActiveRRFViewReport
    },


     {
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
{
    path: '/SelectEntityReport',
    name: 'SelectEntityReport',
    component: SelectEntityReport
},
{
    path: '/SelectAnnualReport',
    name: 'SelectAnnualReport',
    component: SelectAnnualReport
},
{
    path: '/ReportAnnual',
    name: 'ReportAnnual',
    component: ReportAnnual
},
{
    path: '/SelectEntityBiAnnual',
    name: 'SelectEntityBiAnnual',
    component: SelectEntityBiAnnual
},
{
    path: '/SelectReportBiAnnual',
    name: 'SelectReportBiAnnual',
    component: SelectReportBiAnnual
},
{
    path: '/ReportBiAnnual',
    name: 'ReportBiAnnual',
    component: ReportBiAnnual
},
{
    path: '/QuaterlySelectEntity',
    name: 'QuaterlySelectEntity',
    component: QuaterlySelectEntity
},
{
    path: '/QuaterlySelectReport',
    name: 'QuaterlySelectReport',
    component: QuaterlySelectReport
},
{
    path: '/ReportQuaterly',
    name: 'ReportQuaterly',
    component: ReportQuaterly
},
{
    path: '/RRFSelectEntity',
    name: 'RRFSelectEntity',
    component: RRFSelectEntity
},
{
    path: '/RRFSelectReport',
    name: 'RRFSelectReport',
    component: RRFSelectReport
},
{
    path: '/RRFReport',
    name: 'RRFReport',
    component: RRFReport
},
{
    path: '/AQuarterlySelectEntity',
    name: 'AQuarterlySelectEntity',
    component: AQuarterlySelectEntity
},

{
    path: '/AQuarterlySelectYear',
    name: 'AQuarterlySelectYear',
    component: AQuarterlySelectYear
},


{
    path: '/AQuarterlySelectReport',
    name: 'AQuarterlySelectReport',
    component: AQuarterlySelectReport
},
{
    path: '/AQuarterlyViewReport',
    name: 'AQuarterlyViewReport',
    component: AQuarterlyViewReport
},
{
    path: '/AAnnualSelectEntity',
    name: 'AAnnualSelectEntity',
    component: AAnnualSelectEntity
},
{
    path: '/AAnnualSelectYear',
    name: 'AAnnualSelectYear',
    component: AAnnualSelectYear
},
{
    path: '/AAnnualSelectReport',
    name: 'AAnnualSelectReport',
    component: AAnnualSelectReport
},
{
    path: '/AViewAnnualReport',
    name: 'AViewAnnualReport',
    component: AViewAnnualReport
},
{
    path: '/ABiAnnualSelectEntity',
    name: 'ABiAnnualSelectEntity',
    component: ABiAnnualSelectEntity
},
{
    path: '/ABiAnnualSelectYear',
    name: 'ABiAnnualSelectYear',
    component: ABiAnnualSelectYear
},
{
    path: '/ABiAnnualSelectReport',
    name: 'ABiAnnualSelectReport',
    component: ABiAnnualSelectReport
},
{
    path: '/ABiViewAnnualReport',
    name: 'ABiViewAnnualReport',
    component: ABiViewAnnualReport
},

// 


]

const router = createRouter({
    history: createWebHistory(),
    routes
})

export default router