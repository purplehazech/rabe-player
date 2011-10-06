
# this is more an example node showing how i intend to invoke classes
node player {
  include base-system,
  #include layman, (and realize pd-overlay, pro-audio and sunrise overlays needed to pull this off)
  include kernel,
  include ntp,
  include ssh,
  include vim,
  include mixxx,
  include jack,
  include puredata,
  include faderstart,
  include xfce4,
  include player,
}

