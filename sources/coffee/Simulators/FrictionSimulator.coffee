class FrictionSimulator extends Simulator

  setup: (options) ->

    @options = Defaults.get "FrictionSimulator", options
    @options = Utils.defaults options,
      velocity: 0
      position: 0

    @_state =
      x: @options.position
      v: @options.velocity

    @_integrator = new Integrator (state) =>
      return - (@options.friction * state.v)

  next: (delta) ->

    @_state = @_integrator.integrateState(@_state, delta)

    return @_state

  finished: =>

    Math.abs(@_state.v) < @options.tolerance
