"""
    Video

Defines the video canvas for an animation.

# Fields
- `width::Int` the width in pixel
- `height::Int` the height in pixel
- `objects::Vector{AbstractObject}` the objects defined in this video
- `layers::Vector{AbstractObject}` the layers defined in this video
- `background_frames::Vector{Int}` saves for which frames a background is defined
- `defs::Dict{Symbol, Any}` Some definitions which should be accessible throughout the video.
"""
mutable struct Video
    width::Int
    height::Int
    objects::Vector{AbstractObject}
    layers::Vector{AbstractObject}
    background_frames::Vector{Int}
    defs::Dict{Symbol,Any}
end

"""
    CURRENT_VIDEO

holds the current video in an array to be declared as a constant
The current video can be accessed using CURRENT_VIDEO[1]
"""
const CURRENT_VIDEO = Array{Video,1}()


"""
    Video(width, height)

Create a video with a certain `width` and `height` in pixel.
This also sets `CURRENT_VIDEO`.
"""
function Video(width, height)
    # some luxor functions need a drawing ;)
    Drawing()
    video =
        Video(width, height, AbstractObject[], AbstractObject[], Int[], Dict{Symbol,Any}())
    set_constant!(CURRENT_VIDEO, video)
    empty!(CURRENT_OBJECT)
    return video
end
