request = require('request-promise-native')

import logger from '../log'
import sleep from './sleep'

statistics =
    ok: 0
    fail: 0

STATS_MULTIPLIER = 1 - 1.0/100

addStats = (type) ->
    for t of statistics
        statistics[t] *= STATS_MULTIPLIER
    statistics[type] += 1

export getStats = () ->
    return statistics

export default download = (href, jar, options) ->
    #logger.info "Downloading", href
    if not jar
        jar = request.jar()
    delay = 5
    maxAttempts = options?.maxAttempts || 8
    for i in [1..maxAttempts]
        try
            page = await request({
                options...,
                url: href
                jar: jar,
                gzip: true,
                timeout: options?.timeout || 7 * 1000
            })
            extract = page.substring(0, 500)
            #logger.info "Downloaded #{href} -> `#{extract}...`"
            addStats("ok")
            return page
        catch e
            logger.info "Error downloading " + href + " " + i + " will re-download"
            logger.info e.message
            await sleep(delay)
            delay *= 2
    addStats("fail")
    throw "Can't download " + href
