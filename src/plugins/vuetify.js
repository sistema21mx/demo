import Vue from 'vue';
import Vuetify from 'vuetify';
import 'vuetify/dist/vuetify.min.css';
import es from './es';

Vue.use(Vuetify);

export default new Vuetify({
    lang: {
        locales: { es },
        current: 'es'
      },
      icons: {
        iconfont: 'mdi',
      },
      theme: {
        themes: {
          light: {
            primary: '#3498DB',
            secondary: '#6c757d',
            accent: '#3ea2fb',
            error: '#dc3545',
            petrol: '#17a499',
            background: '#fff',
            }
          },
           options: {
             customProperties: true
           },
      },
});
