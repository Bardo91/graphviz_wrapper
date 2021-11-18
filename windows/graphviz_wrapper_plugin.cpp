#include "include/graphviz_wrapper/graphviz_wrapper_plugin.h"

// This must be included before many other Windows headers.
#include <windows.h>

// For getPlatformVersion; remove unless needed for your plugin implementation.
#include <VersionHelpers.h>

#include <flutter/method_channel.h>
#include <flutter/plugin_registrar_windows.h>
#include <flutter/standard_method_codec.h>

#include <map>
#include <memory>
#include <sstream>

#include <graphviz/gvc.h>

namespace {

class GraphvizWrapperPlugin : public flutter::Plugin {
 public:
  static void RegisterWithRegistrar(flutter::PluginRegistrarWindows *registrar);

  GraphvizWrapperPlugin();

  virtual ~GraphvizWrapperPlugin();

 private:
  // Called when a method is called on this plugin's channel from Dart.
  void HandleMethodCall(
      const flutter::MethodCall<flutter::EncodableValue> &method_call,
      std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result);
};

// static
void GraphvizWrapperPlugin::RegisterWithRegistrar(
    flutter::PluginRegistrarWindows *registrar) {
  auto channel =
      std::make_unique<flutter::MethodChannel<flutter::EncodableValue>>(
          registrar->messenger(), "graphviz_wrapper",
          &flutter::StandardMethodCodec::GetInstance());

  auto plugin = std::make_unique<GraphvizWrapperPlugin>();

  channel->SetMethodCallHandler(
      [plugin_pointer = plugin.get()](const auto &call, auto result) {
        plugin_pointer->HandleMethodCall(call, std::move(result));
      });

  registrar->AddPlugin(std::move(plugin));
}

GraphvizWrapperPlugin::GraphvizWrapperPlugin() {}

GraphvizWrapperPlugin::~GraphvizWrapperPlugin() {}

void GraphvizWrapperPlugin::HandleMethodCall(
    const flutter::MethodCall<flutter::EncodableValue> &method_call,
    std::unique_ptr<flutter::MethodResult<flutter::EncodableValue>> result) {
  if (method_call.method_name().compare("getPlatformVersion") == 0) {
    std::ostringstream version_stream;
    version_stream << "Windows ";
    if (IsWindows10OrGreater()) {
      version_stream << "10+";
    } else if (IsWindows8OrGreater()) {
      version_stream << "8";
    } else if (IsWindows7OrGreater()) {
      version_stream << "7";
    }
    result->Success(flutter::EncodableValue(version_stream.str()));
  } else {
    result->NotImplemented();
  }
}

}  // namespace

void GraphvizWrapperPluginRegisterWithRegistrar(
    FlutterDesktopPluginRegistrarRef registrar) {
  GraphvizWrapperPlugin::RegisterWithRegistrar(
      flutter::PluginRegistrarManager::GetInstance()
          ->GetRegistrar<flutter::PluginRegistrarWindows>(registrar));
}


//---------------------------------------------------------------------------------------------------------------------
extern "C" __declspec(dllexport) 
void *native_agmemread(char *_str) {
  return (void*) agmemread(_str);
}

//---------------------------------------------------------------------------------------------------------------------
extern "C" __declspec(dllexport) 
void *native_agnode(void* _graph, char *_name, int _cflag) {
  return (void*) agnode(static_cast<Agraph_t*>(_graph), _name, _cflag);
}

//---------------------------------------------------------------------------------------------------------------------
extern "C" __declspec(dllexport) 
int native_agsafeset(void *_obj, char *_name, char *_value, char *_def) {
  return agsafeset(static_cast<Agraph_t*>(_obj), _name, _value, _def);
}

//---------------------------------------------------------------------------------------------------------------------
extern "C" __declspec(dllexport) 
void *native_gvContext() {
  return (void*) gvContext();
}

//---------------------------------------------------------------------------------------------------------------------
extern "C" __declspec(dllexport) 
int native_gvLayout(void *_gvc, void *_graph, const char *_engine){
  return gvLayout(static_cast<GVC_t *>(_gvc), static_cast<graph_t *>(_graph), _engine);
}

//---------------------------------------------------------------------------------------------------------------------
extern "C" __declspec(dllexport) 
int native_gvRenderFilename (void *_gvc, void *_graph, const char *_format, const char *_filename){
  return gvRenderFilename(static_cast<GVC_t *>(_gvc), static_cast<graph_t *>(_graph), _format, _filename);
}

//---------------------------------------------------------------------------------------------------------------------
extern "C" __declspec(dllexport) 
int native_gvFreeLayout(void * _gvc, void * _graph){
  return gvFreeLayout(static_cast<GVC_t *>(_gvc), static_cast<graph_t *>(_graph));
}

//---------------------------------------------------------------------------------------------------------------------
extern "C" __declspec(dllexport) 
int native_agclose(void * _graph){
  return agclose(static_cast<Agraph_t *>(_graph));
}