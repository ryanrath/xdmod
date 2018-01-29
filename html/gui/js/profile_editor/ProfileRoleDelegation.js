XDMoD.ProfileRoleDelegation = Ext.extend(Ext.Panel,  {

   autoHeight: true,
   border:false,
   frame: true,
   resizable:false,
   title:'Role Delegation',
   cls:'role_manager',

   initComponent: function(){

      var self = this;

      var storeCenterStaff = new Ext.data.JsonStore({

         url: 'controllers/role_manager.php',
         baseParams: {operation: 'enum_center_staff_members'},
         root: 'members',
         autoLoad: true,
         fields: ['id', 'name']

      });//storeCenterStaff

      // ---------------------------------------------------------

      storeCenterStaff.on('load', function(store, records, options){

         var recordsFound = records.length > 0;

         lblStatus.setVisible(!recordsFound);

         sectionAssign.setVisible(recordsFound);
         lblMemberStatus.setVisible(recordsFound);

         XDMoD.utils.syncWindowShadow(self);

      });

      // ---------------------------------------------------------

      var cmbCenterStaff = new Ext.form.ComboBox({

         editable: false,
         fieldLabel: 'Staff Member',
         store: storeCenterStaff,
         triggerAction: 'all',
         displayField: 'name',
         valueField: 'id',
         emptyText: 'No Member Selected',

         listeners:{

            select:function(combo, value, index) {

               var conn = new Ext.data.Connection();
               conn.request({

                   url: 'controllers/role_manager.php',
                  params: {operation: 'get_member_status', member_id: combo.getValue()},
                  method: 'POST',
                   callback: function(options, success, response) {

                     if (success) {

                        var json = Ext.util.JSON.decode(response.responseText);

                        if (json.success) {

                           if (json.eligible == true)
                              lblMemberStatus.update('');
                           else
                              lblMemberStatus.update('<p><b>' + combo.getRawValue() + '</b></p><p>' + json.message + '</p>');

                           btnElevateUser.setVisible(json.eligible);
                           btnDowngradeUser.setVisible(!json.eligible);
                           //lblMemberStatus.setVisible(!json.eligible);  <-- does not work well in Opera

                        }
                        else {

                           lblMemberStatus.update('<p><b>' + combo.getRawValue() + '</b></p><span style="color: #00f">' + json.message + '</span>');
                           lblMemberStatus.setVisible(true);

                           btnElevateUser.setVisible(false);
                           btnDowngradeUser.setVisible(false);
                        }

                        XDMoD.utils.syncWindowShadow(self);

                     }
                     else {
                        Ext.MessageBox.alert('Role Manager', 'There was a problem connecting to the portal service provider.');
                     }

                  }//callback

               });//conn.request

            }//select

         }//listeners

      });//cmbCenterStaff

      // ---------------------------------------------------------

       var sectionAssign = new Ext.Panel({
           hidden: true,

           items: [
               new Ext.Panel({
                   labelWidth: 95,
                   padding: '5px',
                   frame: true,
                   title: 'Delegate Center Staff Privileges',
                   defaults: {
                       width: 200
                   },
                   layout: 'form',
                   items: [
                       cmbCenterStaff
                   ]
               })
           ]

       });// sectionAssign

      // ---------------------------------------------------------

      var btnElevateUser = new Ext.Button({

         text: 'Upgrade Staff Member To Center Director',
         hidden: true,

         handler: function() {

            var conn = new Ext.data.Connection();
            conn.request({

               url: 'controllers/role_manager.php',
               params: {operation: 'upgrade_member', member_id: cmbCenterStaff.getValue()},
               method: 'POST',
               callback: function(options, success, response) {

                  if (success) {

                     var json = Ext.util.JSON.decode(response.responseText);

                     if (json.success) {

                        lblMemberStatus.update('<p><b>' + cmbCenterStaff.getRawValue() + '</b></p><p>' + json.message + '</p>');

                        btnElevateUser.setVisible(false);
                        btnDowngradeUser.setVisible(true);
                        lblMemberStatus.setVisible(true);

                        XDMoD.utils.syncWindowShadow(self);
                     }
                     else
                       Ext.MessageBox.alert('Role Manager', json.message);


                  }
                  else {
                     Ext.MessageBox.alert('Role Manager', 'There was a problem connecting to the portal service provider.');
                  }

               }//callback

            });//conn.request

         }

      });//btnElevateUser

      // ---------------------------------------------------------

      var btnDowngradeUser = new Ext.Button({

         text: 'Revoke Center Director Privileges',
         hidden: true,

         handler: function() {

            var conn = new Ext.data.Connection();
            conn.request({

               url: 'controllers/role_manager.php',
               params: {operation: 'downgrade_member', member_id: cmbCenterStaff.getValue()},
               method: 'POST',
               callback: function(options, success, response) {

                  if (success) {

                     var json = Ext.util.JSON.decode(response.responseText);

                     if (json.success) {

                        btnDowngradeUser.setVisible(false);
                        btnElevateUser.setVisible(true);

                        lblMemberStatus.update('');

                        //lblMemberStatus.setVisible(false);

                        XDMoD.utils.syncWindowShadow(self);
                     }
                     else
                       Ext.MessageBox.alert('Role Manager', json.message);


                  }
                  else {
                     Ext.MessageBox.alert('Role Manager', 'There was a problem connecting to the portal service provider.');
                  }

               }//callback

            });//conn.request

         }

      });//btnDowngradeUser

      // ---------------------------------------------------------

      var lblMemberStatus = new Ext.BoxComponent ({
         hidden: true,
         cls: 'lbl_member_status',
         autoHeight: true,
         html: 'Select a staff member using the list above.'
      });

      // ---------------------------------------------------------

      var lblStatus = new Ext.BoxComponent ({
         hidden: true,
         html: '<center><div style="padding-top: 6px; color: #000">No staff members for your center could be found.<br /><br />' +
               'Please contact the XDMoD portal team at<br /><a href="mailto:' + CCR.xdmod.tech_support_recipient + '?subject=Center Staff Accounts">' + CCR.xdmod.tech_support_recipient + '</a>' +
               '<br />to request center staff accounts.<br /><br />' +
               'You will be able to use this feature once<br />center staff accounts have been established.</div></center>'
      });

      // ---------------------------------------------------------

      this.on('render', function() {
         storeCenterStaff.load();
      });

      Ext.apply(this, {

         items:[
            sectionAssign,
            lblMemberStatus,
            new Ext.Panel({
               buttonAlign: 'center',

               buttons: [
                  btnElevateUser,
                  btnDowngradeUser
               ]
            }),
            lblStatus
         ],

         bbar: {

            items: [
               '->',
               self.parentWindow.getCloseButton()
            ]

         }

      });

      XDMoD.ProfileRoleDelegation.superclass.initComponent.call(this);

   }//initComponent

});//XDMoD.ProfileRoleDelegation
