<template>
  <v-container>
      <v-card>
        <v-card-title class="primary darken-1">
          <span class="subtitle-2 white--text">{{ formTitle }}</span>
          <v-spacer></v-spacer>
          <v-tooltip bottom>
            <template v-slot:activator="{ on }">
              <v-btn dark icon @click.stop="closEditDialog();" v-on="on">
                <v-icon>mdi-chevron-left</v-icon>
              </v-btn>
            </template>
            <span>Salir</span>
          </v-tooltip>&nbsp;
          <v-tooltip bottom>
            <template v-slot:activator="{ on }">
              <v-btn dark icon @click.stop="editFocus('text_name');" v-on="on" v-show="!isEditing">
                <v-icon>mdi-pencil</v-icon>
              </v-btn>
            </template>
            <span>Editar</span>
          </v-tooltip>&nbsp;
          <v-tooltip bottom>
            <template v-slot:activator="{ on }">
              <v-btn dark icon @click.stop="savEdit();" v-on="on" v-show="isEditing">
                <v-icon>check</v-icon>
              </v-btn>
            </template>
            <span>Salvar</span>
          </v-tooltip>&nbsp;
        </v-card-title>
        <v-card-text>
          <v-container>
            <v-form>
              <v-row>


                <v-col cols="12" sm="6" md="8">
                  <v-text-field id="text_name" ref="text_name" v-on:keyup="keymonitor" :rules="[rules.required]" :disabled="!isEditing"
                    v-model="editedItem.name" label="Nombre"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <v-text-field id="text_branch" ref="text_branch" v-on:keyup="keymonitor" :rules="[rules.required]" :disabled="!isEditing"
                    v-model="editedItem.branch" label="Sucursal"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <v-text-field id="text_account" ref="text_account" v-on:keyup="keymonitor" :rules="[rules.required]" :disabled="!isEditing"
                    v-model="editedItem.account" label="Cuenta"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <v-text-field id="text_clabe" ref="text_clabe" v-on:keyup="keymonitor" :rules="[rules.required]" :disabled="!isEditing"
                    v-model="editedItem.clabe" label="CLABE"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <v-text-field id="text_initialBalance" ref="text_initialBalance" v-on:keyup="keymonitor" :disabled="!isEditing"
                    v-model="editedItem.initialBalance" label="Saldo Inicial"></v-text-field>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <v-dialog
                    ref="dialoginitialDay"
                    v-model="pickModalinitialDay"
                    :return-value.sync="editedItem.initialDay"
                    persistent
                    width="290px">
                    <template v-slot:activator="{ on }">
                      <v-text-field
                        id="text_initialDay" ref="text_initialDay"
                        v-model="editedItem.initialDay"
                        label="Fecha Saldo Inicial"
                        prepend-icon="event"
                        readonly
                        v-on="on"
                        :disabled="!isEditing"
                        hint="AAAA-MM-DD" persistent-hint
                      ></v-text-field>
                    </template>
                    <v-date-picker 
                      v-model="editedItem.initialDay" 
                      @input="$refs.dialoginitialDay.save(editedItem.initialDay);pickModalinitialDay = false"
                      >
                    </v-date-picker>
                  </v-dialog>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <h4>Fondo</h4>
                  <v-select2 
                    class="style-chooser"
                    placeholder="Elija un fondo"
                    v-model="editedItem.fund_id" 
                    :options="optSelectfund_id" 
                    :reduce="opt => opt.val" 
                    :filterable="true"
                    :disabled="!isEditing"
                    id="text_fund_id" ref="text_fund_id"
                    label="opt">
                    <div slot="no-options">No existe coincidencia!</div>
                  </v-select2>
                </v-col>
                <v-col cols="12" sm="6" md="4">
                  <v-select id="text_active" ref="text_active" 
                    v-model="editedItem.active"
                    label="Es Activo?"
                    :items="selectItemYN"
                    :disabled="!isEditing"
                    item-text="item"
                    item-value="val"
                  ></v-select>
                </v-col>

              </v-row>
            </v-form>
          </v-container>
        </v-card-text>

      </v-card>
  </v-container>
</template>

<script>
import {mixshared} from '@/mixins/mixshared.js'
import 'vue-select/dist/vue-select.css';

export default {
  name: 'BankaEdt',
  mixins: [mixshared],
  props: ['item'],
  components: {
    //
  },
  data: () => ({
    //
    pickModalinitialDay: false,
    optSelectfund_id: [
      {opt: 'Leyendo', val: null}
    ],
  }),
  methods: {
    initialize: async function () {
      //
      await this.getfund_id()
      this.editedItem = await this.item
      this.editedItem.user_id = await this.userData.data.userId
      if(await this.editedItem.fund_id!==null){
        this.editedItem.fund_id = await Number(this.editedItem.fund_id)
      }
      if(await this.editedItem.id===0){
        await this.editFocus('text_name')
        this.editedItem.initialDay = await this.getToday()
      }
    },
    savEdit: async function () {
      this.$store.dispatch('loadUpPage')
      let message = ''
      let type = 'info'
      if(await this.validationFields()){
        //
        this.$store.dispatch('loadOverlay', true)
        if (await this.editedItem.id !== 0) {
          await this.updateRow()
        } else {
          await this.createRow()
        }
        if(await this.loadData===1 && await this.responseData.length !== 0){
          message = this.responseData.message
          if(this.responseData.error===0){
            this.closEditDialog()
          } else {
            type = 'error'
          }
        } else {
          type = 'error'
          message = 'Error: No actualizo el registro'
        }
        await this.$store.dispatch('loadMessage', { msg: message, type: type })
        if(await this.responseData.column){
          await this.getFocus(this.responseData.column)
        }
      }
    },
    validationFields: function () {
        this.editedItem.name = this.trimField(this.editedItem.name)
        this.editedItem.branch = this.trimField(this.editedItem.branch)
        this.editedItem.account = this.trimField(this.editedItem.account)
        this.editedItem.clabe = this.trimField(this.editedItem.clabe)
        this.editedItem.fund_id = this.trimField(this.editedItem.fund_id)
        
        let isValid = true
        let message = null


        if (this.editedItem.name === null && message === null) {
          message = 'Aviso: Ingresar Nombre'
          document.getElementById('text_name').focus()
        }
        if (this.editedItem.branch === null && message === null) {
          message = 'Aviso: Ingresar Sucursal'
          document.getElementById('text_branch').focus()
        }
        if (this.editedItem.account === null && message === null) {
          message = 'Aviso: Ingresar Cuenta'
          document.getElementById('text_account').focus()
        }
        if (this.editedItem.clabe === null && message === null) {
          message = 'Aviso: Ingresar CLABE'
          document.getElementById('text_clabe').focus()
        }
        if (this.editedItem.fund_id === null && message === null) {
          message = 'Aviso: Ingresar Fondo'
          document.getElementById('text_fund_id').focus()
        }
        //
        if(message!==null){
          this.$store.dispatch('loadMessage', { msg: message, type: 'error' })
          isValid = false
        }
        return isValid
    },
    updateRow: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/bankupdate'
      const dataRespond = this.typeDataRespond
      const formData = await this.editedItem
      const jwToken = await this.loadKeyPass
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      // this.responseData = await []
    },
    createRow: async function () {
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/bankcreate'
      const dataRespond = await this.typeDataRespond
      this.editedItem.user_id = await this.userData.data.userId
      const formData = await this.editedItem
      const jwToken = await this.loadKeyPass // this.userData.data.token
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      // this.responseData = await []
    },
    keymonitor: function (event) {
      if (event.key === 'Enter') {
        this.savEdit()
      }
    },
    getfund_id: async function () {
      //
      const methodWay = await this.methodWay
      const baseURI = await this.urlApi + '/fundids'
      const dataRespond = await this.typeDataRespond
      const formData = await {}
      const jwToken = await this.loadKeyPass // this.userData.data.token
      this.loading = await true
      await this.getAxData(methodWay, baseURI, dataRespond, formData, jwToken)
      this.loading = await false
      this.optSelectfund_id = await this.responseData.data
      this.responseData = await null
    },
    processData: function () {
      //
    }
  },
  created () {
    //
  },
  mounted () {
    //
    this.initialize()
  },
  updated () {
    //
  },
  watch: {
    //
  },
  computed: {
    //
    formTitle: function () {
      return this.editedItem.id === 0 ? this.labelBar + ' (Nuevo)' : this.labelBar + ' (Editando)' 
    }
  }
}
</script>
<style scoped lang="scss">
  .style-chooser .vs__no-options{
    color: #ff6347;
    font-size: 14px;
  }
  .style-chooser .vs__dropdown-toggle{
    height: 28px;
    font-size: 14px;
  }
  .style-chooser .vs__search::placeholder,
  .style-chooser .vs__dropdown-menu {
    font-size: 14px;
  }
  .style-chooser .vs__clear,
  .style-chooser .vs__open-indicator {
    fill: #0000FF;
  }
</style>
