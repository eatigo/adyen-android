/*
 * Copyright (c) 2017 Adyen N.V.
 *
 * This file is open source and available under the MIT license. See the LICENSE file for more info.
 *
 * Created by timon on 06/09/2017.
 */

package com.adyen.checkout.nfc.internal;

import android.support.annotation.NonNull;
import android.support.annotation.Nullable;

import java.util.Arrays;

public abstract class ByteParsable {
    private byte[] mBytes = new byte[0];

    ByteParsable() { }

    @Override
    public boolean equals(@Nullable Object o) {
        if (this == o) {
            return true;
        }
        if (o == null || getClass() != o.getClass()) {
            return false;
        }

        ByteParsable that = (ByteParsable) o;

        return Arrays.equals(mBytes, that.mBytes);
    }

    @Override
    public int hashCode() {
        return Arrays.hashCode(mBytes);
    }

    @NonNull
    @Override
    public String toString() {
        return ByteUtil.bytesToHexFormatted(mBytes);
    }

    @NonNull
    public byte[] getBytes() {
        return Arrays.copyOf(mBytes, mBytes.length);
    }

    public int getByteCount() {
        return mBytes != null ? mBytes.length : 0;
    }

    /**
     * Parses a byte array.
     *
     * @param bytes The bytes to parse.
     * @return The number of bytes that were parsed.
     */
    public abstract int parse(@NonNull byte[] bytes);

    protected void clear() {
        setBytes(new byte[0]);
    }

    protected void setBytes(@NonNull byte[] bytes) {
        this.mBytes = bytes;
    }
}
