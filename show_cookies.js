// show cookies on a human readable way. It is helpful for IE11
// for console
alert(document.cookie.replace(/;/g, '\n--------\n'))
console.log(document.cookie.replace(/;/g, '\n--------\n'))

// as bookmarklet
javascript:(function(){alert(document.cookie.replace(/;/g, '\n--------\n'));console.log(document.cookie.replace(/;/g, '\n--------\n'))})()
