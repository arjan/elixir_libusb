defmodule LibUsb do
  require Logger

  @nif_not_loaded_err "nif not loaded"

  @on_load :load_nif
  @doc false
  def load_nif do
    nif_file = '#{:code.priv_dir(:libusb)}/libusb_nif'

    case :erlang.load_nif(nif_file, 0) do
      :ok -> :ok
      {:error, {:reload, _}} -> :ok
      {:error, reason} -> Logger.warn("Failed to load nif: #{inspect(reason)}")
    end
  end

  def list_devices, do: :erlang.nif_error(@nif_not_loaded_err)
  def get_handle(_id_vendor, _id_product), do: :erlang.nif_error(@nif_not_loaded_err)
  def release_handle(_handle), do: :erlang.nif_error(@nif_not_loaded_err)

  @spec ctrl_send(handle :: reference, integer, integer, integer, integer, binary, integer) :: any
  def ctrl_send(_handle, _request_type, _request, _value, _index, _data, _timeout),
    do: :erlang.nif_error(@nif_not_loaded_err)

  def ctrl_receive(_handle, _request_type, _request, _value, _index, _timeout),
    do: :erlang.nif_error(@nif_not_loaded_err)
end