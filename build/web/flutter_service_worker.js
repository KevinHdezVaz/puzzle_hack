'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "version.json": "c0ce090632203c862a5f1c80188d4b52",
"index.html": "15209cdf70b952c800413e49d88d066a",
"/": "15209cdf70b952c800413e49d88d066a",
"main.dart.js": "0c422624cb1ad70c6d823c8e4697c892",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "963f97c3783c37882a0f71e1ebe95acc",
"assets/AssetManifest.json": "c2841de9045f6f7c0f63738e85532d97",
"assets/NOTICES": "f9c8816fda72e0b32cb579d08a2b8b2f",
"assets/FontManifest.json": "51b74956c80b31753efb50bd899945fc",
"assets/fonts/MaterialIcons-Regular.otf": "7e7a6cccddf6d7b20012a548461d5d81",
"assets/assets/brain2.json": "8108d952ee88d6f2ad3912429f251751",
"assets/assets/images/dash.png": "ac9d3e804bfc692c064b9647e3ebff5b",
"assets/assets/images/faons.png": "f3ed5a8a39e1961dab2c437854023b44",
"assets/assets/images/redes2.png": "069b4f97dc6d313a68b4d9e25b6a73ea",
"assets/assets/images/bombilla.png": "95c02ee048e77d8daafa79e7233349ed",
"assets/assets/images/rompe.png": "359c027a7a42090c673bb64f619d4120",
"assets/assets/images/jungle.png": "0aa86d386309949394055003f61543a0",
"assets/assets/images/logoimagen.png": "b16fab67c93b9af3401976d67bbefe10",
"assets/assets/images/multijugador.png": "a16e0c417e4b5b05013f4a1b71d7321a",
"assets/assets/images/redes.png": "65f2058359e6234f86628c3bf57d1a43",
"assets/assets/images/hero-dash.png": "1e270352a48a85ef03d2095f62bbf84f",
"assets/assets/images/fas.png": "303af75c9559e88a5612188113fe12c6",
"assets/assets/images/relax-dash.png": "d678208361c52b6cfab0f38bd97d868d",
"assets/assets/sounds/clika.mp3": "67aa817b6518a53fd5f6c811c46360b6",
"assets/assets/sounds/clics.mp3": "28d48623c88a0173474ac62bed44b2f4",
"assets/assets/icons/MyFlutterApp.ttf": "20ee893556115ed42253a5a168c7be0d",
"assets/assets/icons/PuzzleIcons.ttf": "0cd4c200dd39858cfa9a3383949a6273",
"assets/assets/lottie/abajo.json": "8096a2848683163c01d6079abaaa7a85",
"assets/assets/lottie/cube.json": "4800b087805866e6d9c8c8617c6fc24a",
"assets/assets/lottie/brain2.json": "8108d952ee88d6f2ad3912429f251751",
"assets/assets/lottie/ganador.json": "9299dad448951507466d9da65f58b4be",
"assets/assets/lottie/puzlee.json": "bcf413fae5a3e1212ae3f40e4ba3511f",
"assets/assets/fonts/Staatliches-Regular.ttf": "d5746e3b20453d6cee99ab27a0bdf949",
"assets/assets/fonts/times.ttf": "3f7dc90a1651b35e69718bbf38ed265a",
"assets/assets/fonts/BebasNeue-Regular.ttf": "21bb70b62317f276f2e97a919ff5bd8c",
"assets/assets/fonts/Viga-Regular.ttf": "caf1116511ef945216d4d56b9752fa76",
"assets/assets/fonts/Keyboard-Icon.ttf": "d11aa2fb210f6fe4387c3ab4ccca39ce",
"assets/assets/fonts/Custom.ttf": "cca5a4e64fe8e5b1b1f25fec8f77fecd",
"assets/assets/figuras/dash.png": "ac9d3e804bfc692c064b9647e3ebff5b",
"assets/assets/figuras/tucan.png": "d6fb0b7414921c103491e8aa987cecac",
"assets/assets/figuras/tiger.png": "a3cdc955d214204a69f377f936fc1ca9",
"assets/assets/figuras/perro.png": "869b766ae1e51b3406fa854c1f436dac",
"assets/assets/figuras/gallina.png": "eefa3da2adfc40da23a24e6915a07ef7",
"assets/assets/figuras/tigre.png": "b39a53cf35d19eb933d1649c78a7eea7",
"assets/assets/figuras/numeric-puzzle.png": "13eb794a84ee7065257aaf13c643afd8",
"assets/assets/figuras/koala.webp": "0441c4b72ad010b3d5965d52b04b45a2",
"assets/assets/figuras/tiburon.png": "3800beeb3e7999b8a5a22205aff91f45",
"assets/assets/figuras/leon.webp": "eaf03bb3ab93021451ad0cc546926a9b",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
