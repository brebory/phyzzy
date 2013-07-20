###
Particles
=========

Particle system writen in literate coffeescript. A module of the Phyzzy physics engine.
Implements extensible particles and emitters to generate particles in a 2D or 3D context.


## Prelude ##
Require the components needed for the particle system.

###

    { zip, box } = require './helpers'
    { DimensionError } = require './errors'
    { Entity } require './entities'


    class Particle extends Entity
      constructor: (position, velocity, direction, @life, @size, @color, in_radians = true) ->
        super position, velocity, direction, in_radians

      update: (dt) ->
        @life -= dt
        super if @life < 0

