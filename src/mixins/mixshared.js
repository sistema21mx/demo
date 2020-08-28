// export default {

export const mixshared = {
  data: () => ({

    //
    systembarHeight: 30,
    systembarLightsOut: true,
    systembarWindow: false,
    //
    btnLoad: false,
    browserName: null,
    //
    responseData: [],
    retrieveData: [],
    methodWay: 'post',
    typeDataRespond: 'json',
    pageNumber: 1,
    // date: new Date().toISOString().substr(0, 10),
    // new Date().toLocaleString("en-US", {timeZone: "America/New_York"})
    // date: new Date(), 
    // getTimeStamp(new Date())
    pickModal: false,
    //
    loading: false,
    //
    editedIndex: -1,
    itemRow: {},
    editedItem: [
    ],
    editedItemDefault: [
    ],
    selectItemYN: [
      { item: 'Si', val: '1' },
      { item: 'No', val: '0' }
    ],
    fileName: null,
    //
    dialogForm: false,
    dialogTitle: 'Titulo',
    dialogText: 'Text',
    dialogReply: null,
    showForm: true,
    //
    maskTel: '##-####-####',
    maskCP: '#######',
    //
    // formTitle: '',
    //
    search: '',
    page: 1,
    pageCount: 0,
    itemsPerPage: -1,
    //
    drawer: false,
    //
    editDialog: false,
    isEditing: null,
    dataPage: {
    },
    // confirmDialog: false,
    dialogComponent: {action: '', title: 'Aviso', msg: 'Mensaje', 
      button1: 'Cancelar', button2: 'Aceptar', 
      action1:'Cancelar', action2:'Aceptar'
      // action1:'closeConfirmDialog', action2:'saveConfirmDialog'
    },
    defaultComponent: {action: '', title: 'Aviso', msg: 'Mensaje', 
      button1: 'Cancelar', button2: 'Aceptar', 
      action1:'Cancelar', action2:'Aceptar'
    },
    rules: {
      required: value => !!value || 'Campo Requerido.',
      counter: value => value.length <= 20 || 'Max 20 characters',
      email: value => {
      const pattern = /^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/
            return pattern.test(value) || 'Invalid e-mail.'
      }
    },
    moneyNumeric: {
      decimal: '.',
      thousands: ',',
      prefix: '',
      suffix: '',
      precision: 2,
      masked: false /* doesn't work with directive */
    },
    moneyNumericInt: {
      decimal: '.',
      thousands: ',',
      prefix: '',
      suffix: '',
      precision: 0,
      masked: false /* doesn't work with directive */
    },
    moneyCurrency: {
      decimal: '.',
      thousands: ',',
      prefix: '$ ',
      suffix: '',
      precision: 2,
      masked: false /* doesn't work with directive */
    },
}),
  methods: {
    // getAxPrint: async function () {
    //
    getAxPrint: async function (methodWay, baseURI, dataRespond, formData, jwToken) {
      // (methodWay, baseURI, dataRespond, formData, jwToken) {

      this.responseData = await []

      await this.axios({
      method: methodWay, url: baseURI,
      responseType: dataRespond, // 'blob'
      data: formData, 
      headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + jwToken
      }
      })
      .then(response => {
        const url = window.URL.createObjectURL(new Blob([response.data]))
        const link = document.createElement('a')
        link.href = url
        link.setAttribute('download', formData.nameFile + '.pdf')
        document.body.appendChild(link)
        link.click()
        document.body.removeChild(link)
        // console.log(response)
      })
      .catch(e => {
        console.log(e)
      })
    },
    getAxData: async function (methodWay, baseURI, dataRespond, formData, jwToken) {
        this.responseData = []
        await this.axios({
        method: methodWay, url: baseURI,
        responseType: dataRespond, // 'json'
        data: formData, 
        headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ' + jwToken
        }
        })
        .then(response => {
            // console.log(response.data)
            // console.log( '*** ' + this.$route.name + ' *** is good !! '  )
            this.responseData = response.data
            this.$store.dispatch('loadLoadData', 1)
        })
        .catch(e => {
            this.$store.dispatch('loadLoadData', 0)
            this.responseData = {'loadData': 0}
            this.responseData.error =  3
            this.responseData.message =  e.name + ': ' + e.message
            // this.responseData.data = {}
            // this.responseData = response.data
            setTimeout(() => {
            if( // this.responseData.loadData === 0 &&
                e.name === 'Error' &&
                e.message === 'Request failed with status code 401'){
                //Error: Request failed with status code 401
                this.checkLogout()
                }
            }, 2000)
            // console.log( '*** ' + this.$route.name + ' *** is Not good !! ' + e )
        })
    },
    loadRoute: function (item) {
        // alert(item.route + ' ' + this.$route.name )
        if(item.route !== this.$route.name){
            this.$store.dispatch('loadUpPage')
            this.$store.dispatch('loadLoadRoute', item)
        }
    },
    loadPageOld: function (val) {
      this.pageNumber = val
    },
    getFocus: function (val) {
        // await this.$refs.val.focus()
        document.getElementById(val).focus()
    },
    editFocus: function (val){
      this.$store.dispatch('loadUpPage')
      this.isEditing = true
      setTimeout(() => {
        document.getElementById(val).focus()
      }, 500)
    },
    closEditDialog: function () {
      this.$store.dispatch('loadUpPage')
      if(this.isEditing===true){
        this.$store.dispatch('loadMessage', 
          { msg: 'Aviso: Se cancelo actualizar registro.', type: 'error' }
        )
      }
      setTimeout(() => {
        this.$emit('setItemRow', {})
        this.$emit('pageChange', 1)
      }, 1000)
    },
    delSessionStorage: function () {
      //
      sessionStorage.removeItem('localLabelBar')
      sessionStorage.removeItem('localUserData')
      sessionStorage.removeItem('localKeyPass')
      sessionStorage.removeItem('localLogDetails')
    },
    checkLogout: function () {
        // sessionStorage.removeItem('localLabelBar')
        this.$store.dispatch('loadLoggedIn', 0)
        // this.$store.dispatch('loadOverlay', true)
        this.$store.dispatch('loadMessage', { msg: 'Aviso: Saliendo del Sistema', type: 'info' })
        this.$store.dispatch('loadUserData', 
            { 'data': {
            error: 1,
            message: '',
            userName: 'userName',
            name: 'Name',
            userId: 'iD',
            // dateStrNow: 'Bienvenido  00/00/0000',
            loginTime: '00:00:00',
            token: ''
            }
            }
        )
        // sessionStorage.removeItem('localUserData')
        // sessionStorage.removeItem('localKeyPass')
        this.loadRoute({ route: 'Home', param: {}, title: '' })
        const itemsModule = [
            {
            action: 'local_activity',
            title: 'Modul title',
            items: [
                { title: 'List title' }
            ]
            }
        ]
        this.$store.dispatch('loadItemsModule', itemsModule)
        this.$store.dispatch('loadKeyPass', 0)
        this.delSessionStorage()
    },
    exitHome: function () {
        sessionStorage.removeItem('localData')
        this.loadRoute({ route: 'Home', param: {}, title: '' }) 
        // this.$store.dispatch('loadOverlay', true)
    },
    trimField: function (dat) {
      if(dat===''){
        dat = null
      }
      if((typeof dat)==='string'){
        dat.replace(/^\s+|\s+$/gm,'')
      }
      // alert(isNaN(dat) + ' ' + dat + ' ' + (typeof dat))
      return dat
    },
    pageUp: function () {
        scroll(0,0)
    },
    printPdf: function () {
      //
    },
    logMessage() {
        // console.log(this.message)
    },
    leadZero: function (val, size) {
      //
      let s = val+''
      while (s.length < size) s = "0" + s;
      return s;
    },
    getColor: function (val) {
      if(val.dateDiff>0 && val.active==='1'){
        return 'E91E63' // Rojo
      }
      if(val.dateDiff<0 && val.active==='1'){
        return '00E676' // Verde
      }
      if(val.paidDate!==null && val.active==='1'){
        return 'blue'  // Pagada
      }
      if(val.active==='0'){
        return 'F57F17'  // Cancelada
      }
    },
    getTimeStamp: function (val) {
      //
      let timestamp = 
      this.leadZero(val.getFullYear(),4) + '-' +
      this.leadZero((val.getMonth() + 1 ),2) + '-' +
      this.leadZero(val.getDate(),2) + ' ' +
      this.leadZero(val.getHours(),2) + ':' +
      this.leadZero(val.getMinutes(),2) + ':' +
      this.leadZero(val.getSeconds(),2)
      return timestamp
    },
    getToday: function () {
      let today = null
      const tz = new Date()
      today = tz.getFullYear() + '-' +
        this.leadZero((tz.getMonth() + 1),2) + '-' + 
        this.leadZero(tz.getDate(),2)
      return today
    },
    foundUniquecode: function (val1, val2) {
      if(val1!==null){
        val1 = val1.toLowerCase()
        // let existingKey = this.keyUniqueCodes.find(a => a === val)
        let existingKey = val2.find(a => a === val1)
        return existingKey
      }
    },
    containsKeyOld: function (arr, element) {
      for (let i = 0; i < arr.length; i++) {
          if (arr[i] === element) {
              return i;
          }
      }
      return undefined;
    },
    browserDetect: function () {

      var ua = navigator.userAgent, tem,
      M = ua.match(/(opera|chrome|safari|firefox|msie|trident(?=\/))\/?\s*(\d+)/i) || [];
      if(/trident/i.test(M[1]))
      {
          tem=  /\brv[ :]+(\d+)/g.exec(ua) || [];
          return 'IE '+(tem[1] || '');
      }
      if(M[1]=== 'Chrome')
      {
          tem= ua.match(/\b(OPR|Edge)\/(\d+)/);
          if(tem!= null) return tem.slice(1).join(' ').replace('OPR', 'Opera');
      }
      M = M[2]? [M[1], M[2]]: [navigator.appName, navigator.appVersion, '-?'];
      if((tem= ua.match(/version\/(\d+)/i))!= null) 
          M.splice(1, 1, tem[1]);
      return M.join(' ');

    },
    // CSV ->
    download: function (headers, items) {
      // var itemsFormatted = [];
      //   // format the data
      //   itemsNotFormatted.forEach((item) => {
      //       itemsFormatted.push({
      //           model: item.model.replace(/,/g, ''), // remove commas to avoid errors,
      //           chargers: item.chargers,
      //           cases: item.cases,
      //           earphones: item.earphones
      //       });
      //   });
      items = JSON.parse(JSON.stringify(items));
      items.forEach(function(item) {
          delete item.identifier;
      });
      let fileName = this.fileName + this.getTimeStamp(new Date()).replace(/ |-|:/g,"").substring(2)
      var fileTitle = fileName; // or 'my-unique-title'
      this.exportCSVFile(headers, items, fileTitle); // call the exportCSVFile() function to process the JSON and trigger the download
    },
    exportCSVFile: function (headers, items, fileTitle) {
      if (headers) {
          items.unshift(headers);
      }
      // Convert Object to JSON
      var jsonObject = JSON.stringify(items);
      var csv = this.convertToCSV(jsonObject);
      var exportedFilenmae = fileTitle + ".csv" || "export.csv";
      var blob = new Blob([csv], { type: "text/csv;charset=utf-8;" });
      if (navigator.msSaveBlob) {
          // IE 10+
          navigator.msSaveBlob(blob, exportedFilenmae);
      } else {
          var link = document.createElement("a");
          if (link.download !== undefined) {
              // feature detection
              // Browsers that support HTML5 download attribute
              var url = URL.createObjectURL(blob);
              // alert(url)
              link.setAttribute("href", url);
              link.setAttribute("download", exportedFilenmae);
              link.style.visibility = "hidden";
              document.body.appendChild(link);
              link.click();
              document.body.removeChild(link);
          }
      }
    },
    /* Export to CSV functions */
    convertToCSV: function (objArray) {
      var array = typeof objArray != "object" ? JSON.parse(objArray) : objArray;
      var str = "";
      var BOM = "\uFEFF"; 
      for (var i = 0; i < array.length; i++) {
          var line = "";
          for (var index in array[i]) {
              if (line != "") line += ", ";
              // line += array[i][index];
              if(typeof(array[i][index])==='string'){
                array[i][index] = array[i][index].replace(/,/g, '')
                if(array[i][index].indexOf(',') > -1){
                  //
                }
              }
              line += array[i][index];
          }
          // str += line + "\r\n";
          str += BOM + line + "\r\n";
      }
      return str;
    },
    // CSV <-
    onlyUnique: function (value, index, self) {
      return self.indexOf(value) === index
    },
    getformatNumber: function (num) {
      // return num.toString().replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,')
      return num.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,')
    },
    getcurrencyFormat: function (num) {
      return '$' + num.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, '$1,')
    },
    getloadData: async function (val) {
      this.$store.dispatch('loadUpPage')
      let message = ''
      let type = 'info'
      if(await this.loadData===1 && await val.length !== 0){
        //
        message = await val.message
        if(await val.error===0){
          // this.closEditDialog()
        } else {
          type = await 'error'
        }
        } else {
          type = await 'error'
          message = await 'Error: No se completo con exito'
        }
        if(message!==null){
          await this.$store.dispatch('loadMessage', { msg: message, type: type })
        }
    },


},
created () {
  //
},
mounted () {
  //
},
updated () {
  //
},
watch: {
  //
},
computed: {
  urlApi: function () {
    return this.$store.getters.getUrlApi
  },
  loadData () {
    return this.$store.getters.getLoadData
  },
  appName () {
    return this.$store.getters.getAppName
  },
  userData () {
    return this.$store.getters.getUserData
  },
  labelBar () {
    return this.$store.getters.getLabelBar
  },
  imageHeight () {
    return this.$store.getters.getImageHeight
  },
  keyUniqueCodes () {
    return this.$store.getters.getKeyUniqueCodes
  },
  loadKeyPass () {
    return this.$store.getters.getKeyPass
  },
  
}

}