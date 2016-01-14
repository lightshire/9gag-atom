NinegagAtomView = require './ninegag-atom-view'
{CompositeDisposable} = require 'atom'

module.exports = NinegagAtom =
  ninegagAtomView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @ninegagAtomView = new NinegagAtomView(state.ninegagAtomViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @ninegagAtomView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'ninegag-atom:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @ninegagAtomView.destroy()

  serialize: ->
    ninegagAtomViewState: @ninegagAtomView.serialize()

  toggle: ->
    console.log 'NinegagAtom was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
