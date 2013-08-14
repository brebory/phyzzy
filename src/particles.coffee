# Particles
# =========
#
# Particle system module of the Phyzzy physics engine.
# Implements extensible particles and emitters to generate particles in a 2D or 3D context.
#
#
# ## Prelude ##
# Require the components needed for the particle system.

    { zip, box } = require './helpers'
    { DimensionError } = require './errors'
    { Entity } require './entities'


    class Particle extends Entity
      constructor: (position, velocity, direction, @life = 1000000, @size = 10, @color = 'blue', in_radians = true) ->
        super position, velocity, direction, in_radians

      update: (dt) ->
        @life -= dt
        super if @life < 0

    class Emitter extends Entity
      constructor: (position, velocity, direction, @max_particles, in_radians = true) ->
        super position.map -> 0, 0, direction.map -> 0, in_radians
        @particle_pool = []
        [0...@max_particles].map (el, index) -> @particle_pool[index] = new Particle position, velocity, direction, in_radians

      update: (dt) ->
        particle.update(dt) for particle in @particle_pool

