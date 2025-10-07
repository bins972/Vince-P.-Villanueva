{{flutter_js}}
{{flutter_build_config}}

// Custom bootstrap to use modern initialization API and CanvasKit renderer
_flutter.loader.load({
  onEntrypointLoaded: function (engineInitializer) {
    engineInitializer
      .initializeEngine({
        // Prefer CanvasKit to avoid deprecated HTML renderer
        renderer: 'canvaskit',
        // Let the engine choose optimal variant automatically
        canvasKitVariant: 'auto'
      })
      .then(function (appRunner) {
        appRunner.runApp();
      });
  }
});