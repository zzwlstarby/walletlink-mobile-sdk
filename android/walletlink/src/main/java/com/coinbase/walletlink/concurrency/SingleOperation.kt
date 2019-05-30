package com.coinbase.walletlink.concurrency

import io.reactivex.Single
import kotlinx.coroutines.GlobalScope
import kotlinx.coroutines.launch
import java.util.concurrent.CountDownLatch

class SingleOperation<T>(private val single: Single<T>) : Operation {
    var result: Result<T>? = null
        private set

    override fun main() {
        val countDownLatch = CountDownLatch(1)
        var response: Result<T>? = null

        GlobalScope.launch {
            single.subscribe({
                response = Result(response = it)
                countDownLatch.countDown()
            }, {
                response = Result(throwable = it)
                countDownLatch.countDown()
            })
        }

        countDownLatch.await()

        this.result = response
    }
}