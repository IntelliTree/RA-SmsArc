Ext.ns('Ext.ux.SmsArc');

// ExtJS 3.x Plugin to provide XML upload view as a button in the
// grid top toolbar. This is only one possible view implementation:
Ext.ux.SmsArc.ImportMessagesPlugin = Ext.extend(Ext.util.Observable,{

  import_url: '/import', //<-- hard-coded controller path

  init: function(grid) {
    this.grid = grid;
    grid.on('render',this.onRender,this);
  },
  
  onRender: function() {
  
    var tbar = this.grid.getTopToolbar();
    if(! tbar) { return; }
    
    // Options button is automatically setup my RapidApp, here we're
    // just checking for it and trying to make sure we insert our 
    // button after it - not needed:
    var optionsBtn = tbar.getComponent('options-button');
    var index = optionsBtn ? tbar.items.indexOf(optionsBtn) + 1 : 1;
    
    this.btn = new Ext.Button({
      text: 'Import Messages (XML)',
      iconCls: 'ra-icon-add',
      handler:this.importHandler, 
      scope: this
    });
    
    tbar.insert(index,this.btn);
  },
  
  importHandler: function() {
  
    var number_field = {
      xtype: 'textfield',
      name: 'phone_id',
      fieldLabel: 'Device Phone #',
      allowBlank: false,
      anchor: '-0'
    };

    var upload_field = {
      xtype: 'fileuploadfield',
      emptyText: 'Select XML Backup File ("SMS Backup & Restore" format)',
      name: 'Filedata',
      buttonText: 'Browse',
      hideLabel: true,
      anchor: '100%'
    };
    
    var fieldset = {
      style: 'border: none',
      hideBorders: true,
      xtype: 'fieldset',
      border: false,
      items:[ number_field, { xtype: 'spacer', height: 10 }, upload_field ]
    };
    
    var plugin = this;
    
    // This is a RapidApp-provided util function which makes it easy
    // to create form dialogs to post to a controller URL
    Ext.ux.RapidApp.WinFormPost.call(this,{
      title: 'Import Messages (XML Backup)',
      width: 450,
      height:170,
      disableBtn: true,
      url: this.import_url, 
      useSubmit: true,
      fileUpload: true,
      fieldset: fieldset,
      success: function(){ plugin.importCallback.apply(plugin,arguments); }
    });
    
  },

  importCallback: function(form,opts) {
    var result = opts.result;
    if(result.success) {
      Ext.Msg.alert("SUCCESS","IMPORTED " + result.added_count + " MESSAGES");
      // reload the store so we can see the updated messages:
      this.grid.store.reload();
    }
    else {
      Ext.Msg.alert("Unexpected Error","Not sure what happened");
    }
  }

});
Ext.preg('smsarc-grid-import-messages',Ext.ux.SmsArc.ImportMessagesPlugin);
