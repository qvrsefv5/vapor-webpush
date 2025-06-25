self.addEventListener("push", (event) => {
  if (event.data) {
    console.log("Push event!! ", event.data.text());
    console.log("Push event!! ", event.data.json());
  } else {
    console.log("Push event but no data");
  }
  const data = event.data ? event.data.json() : {};
  const title = data.title || "Vapor Push";
  const options = {
    body: data.body || "This is a test push notification.",
    // icon: "icon.png",
  };
  console.log("title ", title);
  console.log("options  ", JSON.stringify(options));
  event.waitUntil(
    (async () => {
      await self.registration.showNotification(title, {
        ...options,
        requireInteraction: data.notification.require_interaction ?? false,
      });
    })()
  );
});
