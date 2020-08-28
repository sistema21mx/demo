import Vue from 'vue'
import VueRouter from 'vue-router'
import Home from '../components/Home.vue'
import store from '../store'
Vue.use(VueRouter)

  const routes = [
  {
    path: '/',
    name: 'Home',
    component: Home
  },
]

let DnmcRoutes = [
  {
    path: '/Error404',
    name: 'Error404',
    component: () => import( '../components/Error404/Error404.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/Usuario',
    name: 'Usuario',
    component: () => import( '../components/Usuario/Usuario.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/Profile',
    name: 'Profile',
    component: () => import( '../components/Profile/Profile.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/Menu',
    name: 'Menu',
    component: () => import( '../components/Menu/Menu.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/Template',
    name: 'Template',
    component: () => import( '../components/Template/Template.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/Pruebas',
    name: 'Pruebas',
    component: () => import( '../components/Pruebas/Pruebas.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/Testprnt',
    name: 'Testprnt',
    component: () => import( '../components/Testprnt/Testprnt.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/PartidasPpto',
    name: 'BudgeClo',
    component: () => import( '../components/BudgeClo/BudgeClo.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/Condominios',
    name: 'Condomin',
    component: () => import( '../components/Condomin/Condomin.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/CondminTipos',
    name: 'CondTyp',
    component: () => import( '../components/CondTyp/CondTyp.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/Cuotas',
    name: 'Quota',
    component: () => import( '../components/Quota/Quota.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/Proveedores',
    name: 'Provider',
    component: () => import( '../components/Provider/Provider.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/Gastos',
    name: 'Expense',
    component: () => import( '../components/Expense/Expense.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/RegDepositos',
    name: 'Deposit',
    component: () => import( '../components/Deposit/Deposit.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/RegCuotas',
    name: 'Monthf',
    component: () => import( '../components/Monthf/Monthf.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/ConCuotas',
    name: 'Quotaj',
    component: () => import( '../components/Quotaj/Quotaj.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/ConGastos',
    name: 'Expensej',
    component: () => import( '../components/Expensej/Expensej.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/Inquilino',
    name: 'Tenant',
    component: () => import( '../components/Tenant/Tenant.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/Bancos',
    name: 'Bankacct',
    component: () => import( '../components/Bankacct/Bankacct.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/CuotasExtra',
    name: 'QuotaExt',
    component: () => import( '../components/QuotaExt/QuotaExt.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/Propietario',
    name: 'Owner',
    component: () => import( '../components/Owner/Owner.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/Eventos',
    name: 'Event',
    component: () => import( '../components/Event/Event.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/Aplicacion',
    name: 'Aplicat',
    component: () => import( '../components/Aplicat/Aplicat.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/Mantenimiento',
    name: 'Repair',
    component: () => import( '../components/Repair/Repair.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/Fondos',
    name: 'Fund',
    component: () => import( '../components/Fund/Fund.vue'),
    meta: { requiresAuth: true}
  },
  //
  {
    path: '/Residencial',
    name: 'Residen',
    component: () => import( '../components/Residen/Residen.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/Instalaciones',
    name: 'Faciliti',
    component: () => import( '../components/Faciliti/Faciliti.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/Reservacion',
    name: 'Reservat',
    component: () => import( '../components/Reservat/Reservat.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/Confirmacion',
    name: 'Confirm',
    component: () => import( '../components/Confirm/Confirm.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/Vehiculos',
    name: 'Vehicle',
    component: () => import( '../components/Vehicle/Vehicle.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/EnvioElectronico',
    name: 'Sendmail',
    component: () => import( '../components/Sendmail/Sendmail.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/ProfUsr',
    name: 'ProfUsr',
    component: () => import( '../components/ProfUsr/ProfUsr.vue'),
    meta: { requiresAuth: true}
  },
  
  {
    path: '/EdoCta',
    name: 'Bankstat',
    component: () => import( '../components/Bankstat/Bankstat.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/PptosEg',
    name: 'BudgEx',
    component: () => import( '../components/BudgEx/BudgEx.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/PptosIn',
    name: 'budgIn',
    component: () => import( '../components/budgIn/budgIn.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/ConsumoMedido',
    name: 'Measucon',
    component: () => import( '../components/Measucon/Measucon.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/Cuotadiversa',
    name: 'Dirverse',
    component: () => import( '../components/Dirverse/Dirverse.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/EdoCtaUnidad',
    name: 'Statecom',
    component: () => import( '../components/Statecom/Statecom.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/Recargos',
    name: 'Surcharg',
    component: () => import( '../components/Surcharg/Surcharg.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/Descuentos',
    name: 'Discount',
    component: () => import( '../components/Discount/Discount.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/Pagargasto',
    name: 'PayExpen',
    component: () => import( '../components/PayExpen/PayExpen.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/ConsultaIngresos',
    name: 'Incomes',
    component: () => import( '../components/Incomes/Incomes.vue'),
    meta: { requiresAuth: true}
  },
  {
    path: '/ConsultaEgresos',
    name: 'Expenses',
    component: () => import( '../components/Expenses/Expenses.vue'),
    meta: { requiresAuth: true}
  },




]
const router = new VueRouter({
  mode: 'history',
  base: process.env.BASE_URL,
  routes
})

router.addRoutes(DnmcRoutes)
router.beforeEach((to, from, next) => {
  if (to.meta.requiresAuth) {
    if (store.getters.getLoggedIn === 1) {
      next()
    } else {
      next('/')
    }
  } else {
    next()
  }
})
export default router
