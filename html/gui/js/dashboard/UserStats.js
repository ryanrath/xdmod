Ext.ns('XDMoD');

XDMoD.UserStats = {};

XDMoD.UVGrid = Ext.extend(Ext.grid.GridPanel,  {

   initComponent: function(){

      var self = this;
      var activeTimeframe = 'Year';
      var activeUserTypes = [1,700];

      // ---------------------------------

      var store = new Ext.data.GroupingStore({

         sortInfo:{
            field: 'visit_frequency',
            direction: "DESC"
         },

         proxy: new Ext.data.HttpProxy({
            url:'/internal_dashboard/controllers/controller.php'
         }),

         reader: new Ext.data.JsonReader(

            {
               root: 'stats',
               totalProperty: 'total'
            },

            [

               'last_name',
               'first_name',
               'email_address',
               'timeframe',
               'role_list',
               'visit_frequency',
               'user_type'

            ]

         ),

         baseParams: {
            'operation' : 'enum_user_visits'
         },

         groupField: 'timeframe',
         groupDir: 'DESC'

      });//store

      // ---------------------------------

      self.doit = function(d) {
         console.log(d);
      };

      // ---------------------------------

      self.showVisits = function(timeframe) {

         activeTimeframe = timeframe;

         store.load({
            params: {
               timeframe: timeframe,
               user_types: activeUserTypes.join(',')
            }
         });

      };//self.showVisits

      // ---------------------------------

      self.prepCSV = function() {

         CCR.invokePost('/internal_dashboard/controllers/controller.php', {
            operation: 'enum_user_visits_export',
            timeframe: activeTimeframe,
            user_types: activeUserTypes.join(',')
         }, {
            checkDashboardUser: true
         });

      };//self.prepCSV

      // ---------------------------------

      var groupRenderer = function(val) {

         return activeTimeframe + ': ' + Ext.util.Format.htmlEncode(val);

      };//groupRenderer

      // ---------------------------------

      self.on('afterrender', function() {

         self.showVisits(activeTimeframe);

      });

      // ---------------------------------

      var userTypeRenderer = function(value, metadata, record, rowIndex, colIndex, store) {

         var color = "#000000";

         if (record.data.user_type == "1")   color = "#000000";
         if (record.data.user_type == "2")   color = "#0000ff";
         if (record.data.user_type == "3")   color = "#008800";
         if (record.data.user_type == "700") color = "#b914f6";

         return '<span style="color: ' + color + '">' + Ext.util.Format.htmlEncode(value) + '<span>';

      };//userTypeRenderer

      // ---------------------------------

      self.updateListing = function(selectedUserTypes) {

         activeUserTypes = selectedUserTypes;
         self.showVisits(activeTimeframe);

      };//self.updateListing

      // ---------------------------------

      Ext.apply(this, {

         store: store,

         columns: [

            {header: 'Last Name', width: 40, dataIndex: 'last_name', sortable: true, renderer: userTypeRenderer },
            {header: 'First Name', width: 40, dataIndex: 'first_name', sortable: true, renderer: userTypeRenderer },
            {header: 'E-Mail', width: 50, dataIndex: 'email_address', sortable: true, renderer: userTypeRenderer },
            {header: 'Roles', width: 150, dataIndex: 'role_list', sortable: true, renderer: userTypeRenderer },
            {header: 'Timeframe', width: 100, dataIndex: 'timeframe', sortable: true, hidden: true, groupRenderer: groupRenderer, renderer: userTypeRenderer },
            {header: 'Visit Frequency', width: 100, dataIndex: 'visit_frequency', sortable: true, renderer: userTypeRenderer }

         ],

         view: new Ext.grid.GroupingView({

            forceFit:true,
            groupTextTpl: '{group} ({[values.rs.length]} {[values.rs.length > 1 ? "Distinct users" : "Distinct user"]})'

         }),

         frame:true

      });//Ext.apply

      XDMoD.UVGrid.superclass.initComponent.call(this);

   }//initComponent

});//XDMoD.UVGrid

// ============================================================

XDMoD.UserStats = Ext.extend(Ext.Panel, {

   title: 'User Stats',

   initComponent: function(){

      var self = this;

      var tabPanel = new Ext.TabPanel({

         frame: false,
         border: false,
         activeTab: 0,
         region: 'center',

         defaults: {
            tabCls: 'tab-strip'
         }

      });//tabPanel

      tabPanel.add(new XDMoD.UserStatsComponents.Visitation());

      Ext.apply(this, {

         layout: 'fit',

         items: [tabPanel]

      });//Ext.apply

      XDMoD.UserStats.superclass.initComponent.call(this);

   }//initComponent

});//XDMoD.UserStats

// ============================================================

XDMoD.UserStatsComponents = {};

XDMoD.UserStatsComponents.Visitation = Ext.extend(Ext.Panel, {

   title: 'Visitation',

   initComponent: function(){

      var self = this;

      // ---------------------------------

      var pnlVisitation = new XDMoD.UVGrid({
         region: 'center'
      });

      // ---------------------------------

      var rdoGroupName = Ext.id();

      var rdoTimeframe = new Ext.form.RadioGroup({

         defaultType: 'radio',
         columns: 1,
         margins: '33 0 0 0',
         flex: 1,
         vertical: true,

         cls: 'dashboard_user_stats_timeframe',

         hideEmptyLabel: true,
         hideLabel: true,

         items: [

            {
               boxLabel: 'Yearly',
               checked: true,
               name: rdoGroupName,
               inputValue: 'Year'
            },

            {
               boxLabel: 'Monthly',
               name: rdoGroupName,
               inputValue: 'Month'
            }

         ],

         listeners: {

            change: function(rg, rc) {

               pnlVisitation.showVisits(rc.inputValue);

            }

         }

      });//rdoTimeframe

      // ---------------------------------

      var cbGroupUserTypes = new Ext.form.CheckboxGroup({

         width: 400,

         hideEmptyLabel: true,
         hideLabel: true,

         style: {
            marginLeft: '10px'
         },

         columns: 1,

         items: [

            {
               boxLabel: '<span style="color: #008800">Testing Users</span>',
               name: 'rb',
               inputValue: '3',
               style: {marginTop: '0px'}
            },

            {
               boxLabel: '<span style="color: #0000ff">Internal Users</span>',
               name: 'rb',
               inputValue: '2'
            },

            {
               boxLabel: '<span style="color: #000000">External Users</span>',
               name: 'rb',
               inputValue: '1',
               checked: true
            },

            {
                 boxLabel: '<span style="color: #b914f6">SSO Users</span>',
               name: 'rb',
                 inputValue: '5',
               checked: true
            }

         ],

         listeners: {

            change: function(cbGroup, checked) {

               var selectedUserTypes = [];

               for(i = 0; i < checked.length; i++) {
                  selectedUserTypes.push(checked[i].inputValue);
               }

               if (checked.length == 0) selectedUserTypes = [1,2,3,700];

               pnlVisitation.updateListing(selectedUserTypes);

            }//change

         }//listeners

      });//cbGroupUserTypes

      // -----------------------------------

      var fpUserTypes = new Ext.FormPanel({

         labelWidth: 95,
         frame:true,
         title: 'Show User Types',

         width: 150,

         style: {marginLeft: '10px', marginTop: '10px'},

         defaults: {width: 150},
         labelAlign: 'top',

         items: [

            cbGroupUserTypes

         ]

      });//fpUserTypes

      // -----------------------------------

      var fpTimeframe = new Ext.FormPanel({

         labelWidth: 95,
         frame:true,
         title: 'Timeframe',

         width: 150,

         style: {marginLeft: '10px', marginTop: '10px'},

         defaults: {width: 150},
         labelAlign: 'top',

         items: [

            rdoTimeframe

         ]

      });//fpTimeframe

      // -----------------------------------

      var fpExport = new Ext.FormPanel({

         labelWidth: 95,
         frame:true,
         title: 'Export',

         width: 150,

         style: {marginLeft: '10px', marginTop: '10px'},

         defaults: {width: 137},
         labelAlign: 'top',

         items: [

            new Ext.Button({

               text: 'Export CSV',

               handler: function() {

                  pnlVisitation.prepCSV();

               }

            })

         ]

      });//fpExport

      // -----------------------------------

      Ext.apply(this, {

         layout: 'border',

         items: [

            new Ext.Panel({

               region: 'west',
               width: 170,
               baseCls: 'x-plain',

               items: [

                  fpTimeframe,
                  fpUserTypes,
                  fpExport

               ]

            }),

            pnlVisitation

         ]

      });//Ext.apply

      XDMoD.UserStatsComponents.Visitation.superclass.initComponent.call(this);

   }//initComponent

});//XDMoD.UserStatsComponents.Visitation
