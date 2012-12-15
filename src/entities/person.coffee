ig.module(
  'game.entities.person'
).requires(
  'impact.entity'
).defines ->
  ROW_COUNT = 8
  EPSILON = 1

  window.EntityPerson = ig.Entity.extend
    size:
      x: 7
      y: 8
    type: ig.Entity.TYPE.B
    checkAgainst: ig.Entity.TYPE.A
    animSheet: new ig.AnimationSheet 'media/ppl.png', 8,8
    init: (x,y, settings) ->
      @parent x,y, settings
      @num = Math.floor(Math.random() * ROW_COUNT)
      @addAnim 'idle_down', 5, [0], true
      @addAnim 'idle_up', 5, [3], true
      @addAnim 'run_down', 0.25, [1,2]
      @addAnim 'run_up', 0.25, [4,5]

      if @num
        for own k,anim of @anims
          i=0
          while i < anim.sequence.length
            anim.sequence[i] += @num * 6
            ++i
    update: ->
      if (@vel.y > EPSILON)
        if @currentAnim != @anims.run_down
          @currentAnim = @anims.run_down
      else if (@vel.y < -EPSILON)
        if @currentAnim != @anims.run_up
          @currentAnim = @anims.run_up
      else
        if @currentAnim == @anims.run_down
          @currentAnim = @anims.idle_down
        else if @currentAnim == @anims.run_up
          @currentAnim = @anims.idle_up

      @vel.y += -0.5 + Math.random()
      @vel.x += -0.5 + Math.random()

      @parent arguments...

    check: ->
      @kill()
