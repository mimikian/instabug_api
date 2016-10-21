object @bug
attributes :number, :status, :priority, :comment
child (@state) {
  attributes :os, :device, :memory, :storage
}