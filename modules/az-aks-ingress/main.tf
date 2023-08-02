resource "helm_release" "ingress-nginx" {
  name       = var.ingress_name
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  namespace  = var.namespace_name
  version    = "4.7.1"

  set {
    name  = "controller.ingressClassResource.name"
    value = "${var.ingress_name}"
  }
  set {
    name  = "service.type"
    value = "ClusterIP"
  }
  set {
    name  = "controller.service.type"
    value = "LoadBalancer"
  }
  set {
    name  = "controller.service.loadBalancerIP"
    value = var.ingress_pubip
  }
  set {
    name  = "controller.service.externalTrafficPolicy"
    value = "Local"
  }
  
  ###########################################################
  ####### implement logic (uncoment - lock ingress controller to watch in specified namespace)
  /*
  set {
   name  = "controller.scope.enabled"
   value = "true"
  }
  set {
   name  = "controller.scope.namespace"
   value = var.namespace_name
  }
  set {
    name  = "controller.ingressClassResource.enabled"
    value = "true"
  }
  set {
    name  = "controller.ingressClassResource.default"
    value = "false"
  }
  set {
    name  = "controller.ingressClassResource.controllerValue"
    value = "k8s.io/ingress-nginx"
  }
  /**/
  #############################################################
}
