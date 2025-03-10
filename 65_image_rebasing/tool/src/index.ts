import os from 'os'

interface KeyValue {
  key: string
  value: string
}

function get_process_details(): Array<KeyValue> {
  const variables = new Array<KeyValue>()
  const memUsage = process.memoryUsage()

  Object.keys(memUsage).forEach(function (key) {
    variables.push({ key: 'process.' + key, value: (memUsage as any)[key] })
  })

  try {
    const resourceUsage = process.resourceUsage()
    Object.keys(resourceUsage).forEach(function (key) {
      variables.push({ key: 'process.' + key, value: (resourceUsage as any)[key] })
    })
  } catch (ex) {}

  Object.keys(process.versions).forEach(function (key) {
    variables.push({ key: 'versions.' + key, value: process.versions[key] || '' })
  })

  Object.keys(process.env).forEach(function (key) {
    variables.push({ key: 'env.' + key, value: process.env[key] || '' })
  })

  Object.keys(os.userInfo()).forEach(function (key) {
    //os.userInfo()[key]
    variables.push({ key: 'userInfo.' + key, value: key })
  })

  return variables
}

export function main(): number {
  // var a = 0
  console.log('Hello world!!!!')
  console.log(get_process_details())
  return 0
}

main()
